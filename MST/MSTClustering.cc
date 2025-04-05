//
// Created by _amp_ on 10/21/24.
//

#include "MSTClustering.h"
#include "G4NucleiProperties.hh"
#include "Repulsion.hh"
#include "G4ExcitationHandler.hh"
#include "ExcitationEnergy.h"
#include <limits>
#include <stack>

void MSTClustering::construct_tree(std::vector<edge>&& verticeData, size_t size) {
  tree.clear();
  for (int i = 0; i < size; i++) tree.push_back(std::make_shared<Node>(i));
  std::sort(verticeData.begin(), verticeData.end());
  for (auto it : verticeData) {
    uint v1 = it.second.first;
    uint v2 = it.second.second;
    if (tree[v1].get() != tree[v2].get()) {
      auto newNode = std::make_shared<Node>(std::move(tree[v1]), std::move(tree[v2]), it.first);
      for (const auto vertice : newNode->get_vertices()) tree[vertice] = newNode;
    }
  }
}

std::vector<MSTClustering::edge> GMSTClustering::get_vertices(const cola::EventData& edata) {
  cola::EventParticles particles = edata.particles;
  std::vector<edge> edges;
  for (size_t i = 0; i < particles.size(); i++) {
    for (size_t j = i + 1; j < particles.size(); j++) {
      double temp_dist = 0.0;
      temp_dist += std::pow(particles[i].position.x - particles[j].position.x, 2);
      temp_dist += std::pow(particles[i].position.y - particles[j].position.y, 2);
      temp_dist += std::pow(particles[i].position.z - particles[j].position.z, 2);
      temp_dist = std::sqrt(temp_dist);
      edges.emplace_back(temp_dist, std::make_pair(i, j));
      edges.emplace_back(temp_dist, std::make_pair(j, i));
    }
  }
  return edges;
}

std::unique_ptr<cola::EventData> GMSTClustering::get_clusters(std::unique_ptr<cola::EventData>&& edata, const Node& rootnode) {
  cola::EventParticles nucleons;
  cola::EventParticles nucleons_B;

  cola::EventIniState inistate = (*edata).iniState;
  double pZA = inistate.pZA;
  double pZB = inistate.pZB;
  cola::EventParticles particles = (*edata).particles;

  sourceA = cola::pdgToAZ(inistate.pdgCodeA).first;
  sourceAb = cola::pdgToAZ(inistate.pdgCodeB).first;
  A = 0;
  Ab = 0;
  Z = 0;
  Zb = 0;

  for (auto& particle : particles) {
    auto az = particle.getAZ();
    if (particle.pClass == cola::ParticleClass::spectatorA) {
      nucleons.push_back(particle);
      ++A;
      if (az.second == 1) {
        ++Z;
      }
    }
    if (particle.pClass == cola::ParticleClass::spectatorB) {
      nucleons_B.push_back(particle);
      ++Ab;
      if (az.second == 1) {
        ++Zb;
      }
    }
  }

  auto ExEns = this->get_exens();
  double ExA = ExEns.first;
  double ExB = ExEns.second;

  std::vector<std::vector<cola::Particle*>> outClusters;
  std::vector<cola::Particle*> output_vector_A;
  std::vector<cola::Particle*> output_vector_B;
  std::vector<int> rmapsA;  // repulsion maps with fragments for size A
  std::vector<int> rmapsB;  // repulsion maps with fragments for size B
  int rcountA = 0;
  int rcountB = 0;
  cola::EventParticles rnucsA;  // protons for size A
  cola::EventParticles rnucsB;  // protons for size B

  std::vector<std::vector<uint>> clusters = this->get_connected_components(this->get_cd(ExA, A));
  std::vector<std::vector<uint>> clusters_B = this->get_connected_components(this->get_cd(ExB, Ab));

  output_vector_A = this->fragments_from_clusters(clusters, nucleons);
  output_vector_B = this->fragments_from_clusters(clusters_B, nucleons_B);
  std::cout << "DONE\n";

  outClusters.push_back(output_vector_A);
  outClusters.push_back(output_vector_B);


  for (uint i = 0; i < clusters.size(); ++i) {
    for (uint j = 0; j < clusters[i].size(); ++j) {
      cola::Particle* nucleon = &(nucleons.at((clusters[i])[j]));
      if (nucleon->getAZ().second == 1) {
        rnucsA.push_back(*nucleon);
        rmapsA.push_back(rcountA);
      }
    }
    ++rcountA;
  }

  for (uint i = 0; i < clusters_B.size(); ++i) {
    for (uint j = 0; j < clusters_B[i].size(); ++j) {
      cola::Particle* nucleon = &(nucleons_B.at((clusters_B[i])[j]));
      if (nucleon->getAZ().second == 1) {
        rnucsB.push_back(*nucleon);
        rmapsB.push_back(rcountB);
      }
    }
    ++rcountB;
  }

  auto boostA = this->get_boost(pZA, A);
  auto boostB = this->get_boost(pZB, Ab);

  cola::EventParticles cFragments = this->calculate_momentum(outClusters, ExA, ExB, boostA, boostB, rnucsA, rnucsB, rmapsA, rmapsB);

  return std::make_unique<cola::EventData>(cola::EventData{cola::EventIniState{inistate.pdgCodeA, inistate.pdgCodeB, inistate.pZA, inistate.pZB, inistate.energy, inistate.sectNN, inistate.b, inistate.nColl, inistate.nCollPP, inistate.nCollPN, inistate.nCollNN, inistate.nPart, inistate.nPartA, inistate.nPartB, inistate.phiRotA, inistate.thetaRotA, inistate.phiRotB, inistate.thetaRotB, cFragments}, cFragments});
}

cola::EventParticles GMSTClustering::calculate_momentum(std::vector<std::vector<cola::Particle*>> noMomClusters, double ExEnA, double ExEnB, CLHEP::Hep3Vector boostA, CLHEP::Hep3Vector boostB, cola::EventParticles rnucsA, cola::EventParticles rnucsB, std::vector<int> rmapsA, std::vector<int> rmapsB) {
  cola::EventParticles particles;

  auto momClusters = noMomClusters;
  std::vector<double> MstMassVector_A;
  MstMassVector_A.reserve(noMomClusters.at(0).size());

  std::vector<double> MstMassVector_B;
  MstMassVector_B.reserve(noMomClusters.at(1).size());

  double SumMassMst = 0;
  double SumMassMstEx = 0;

  if (!noMomClusters.at(0).empty()) {
    for (uint i = 0; i < noMomClusters.at(0).size(); ++i) {
      uint clfrag_A = (noMomClusters.at(0)[i])->getAZ().first;
      uint clfrag_Z = (noMomClusters.at(0)[i])->getAZ().second;

      double energy = 0;
      if (!((clfrag_Z == 0 && (clfrag_A == 1)) || (clfrag_Z == 1 && (clfrag_A == 1)))) {
        energy = ExEnA * double(clfrag_A) / double(SpecAa);
      }

      double NuclearMass = G4NucleiProperties::GetNuclearMass(static_cast<G4int>(clfrag_A), static_cast<G4int>(clfrag_Z)) + energy;

      SumMassMst += G4NucleiProperties::GetNuclearMass(static_cast<G4int>(clfrag_A), static_cast<G4int>(clfrag_Z));

      SumMassMstEx += NuclearMass;

      MstMassVector_A.push_back(NuclearMass);
    }

    double PrefragmentMass_A = SumMassMst + ExEnA;

    std::vector<G4LorentzVector*>* momentumVectorA;

    if (PrefragmentMass_A < (SumMassMstEx + 1e-5 * MeV)) {
      PrefragmentMass_A += 1e-5 * MeV;
    }
    momentumVectorA = phaseSpaceDecay.Decay(PrefragmentMass_A, MstMassVector_A);

    for (int I = 0; I < momClusters.at(0).size(); ++I) {
      momClusters.at(0).at(I)->momentum = ToColaLorentzVector(*(momentumVectorA->at(I)));
    }

    momentumVectorA->clear();

    momClusters.at(0) = RepulsionStage::CalculateRepulsion(momClusters.at(0), rnucsA, rmapsA);
    for (int I = 0; I < momClusters.at(0).size(); ++I) {
      auto fragment = momClusters.at(0).at(I);
      cola::LorentzVector momentum = fragment->momentum;
      momentum.boost(boostA.x(), boostA.y(), boostA.z());
      fragment->momentum = momentum;

      particles.push_back(*fragment);
    }
  }

  SumMassMst = 0;
  SumMassMstEx = 0;
  if (!noMomClusters.at(1).empty()) {
    for (uint i = 0; i < noMomClusters.at(1).size(); ++i) {
      uint clfrag_A = (noMomClusters.at(1)[i])->getAZ().first;
      uint clfrag_Z = (noMomClusters.at(1)[i])->getAZ().second;

      double energy = 0;
      if (!((clfrag_Z == 0 && (clfrag_A == 1)) || (clfrag_Z == 1 && (clfrag_A == 1)))) {
        energy = ExEnB * double(clfrag_A) / double(SpecAb);
      }

      double NuclearMass = G4NucleiProperties::GetNuclearMass(static_cast<G4int>(clfrag_A), static_cast<G4int>(clfrag_Z)) + energy;

      SumMassMst += G4NucleiProperties::GetNuclearMass(static_cast<G4int>(clfrag_A), static_cast<G4int>(clfrag_Z));

      SumMassMstEx += NuclearMass;

      MstMassVector_B.push_back(NuclearMass);
    }

    double PrefragmentMass_B = SumMassMst + ExEnB;
    std::vector<G4LorentzVector*> *momentumVectorB;

    if (PrefragmentMass_B < (SumMassMstEx + 1e-5 * MeV)) {
      PrefragmentMass_B += 1e-5 * MeV;
    }
    momentumVectorB = phaseSpaceDecay.Decay(PrefragmentMass_B, MstMassVector_B);


    for (int I = 0; I < momClusters.at(1).size(); ++I) {
      momClusters.at(1).at(I)->momentum = ToColaLorentzVector(*momentumVectorB->at(I));
    }

    momentumVectorB->clear();

    momClusters.at(1) = RepulsionStage::CalculateRepulsion(momClusters.at(1), rnucsB, rmapsB);
    for (int I = 0; I < momClusters.at(1).size(); ++I) {
      auto fragment = momClusters.at(1).at(I);
      cola::LorentzVector momentum = fragment->momentum;
      momentum.boost(boostB.x(), boostB.y(), boostB.z());
      fragment->momentum = momentum;

      particles.push_back(*fragment);
    }
  }

  MstMassVector_A.clear();
  MstMassVector_B.clear();
  noMomClusters.clear();
  momClusters.clear();

  return particles;
}

double GMSTClustering::get_cd(double Ex, uint A) {
  if ((Ex / double(A)) < 2.17 * MeV) {
    return d0;
  }
  double ex = Ex / double(A);
  double dep = std::exp(-std::pow((ex / b_opt), a_opt)) * c_opt + d_opt;
  return d0 * std::pow(dep, 1. / 3.);
}

std::vector<cola::Particle*> GMSTClustering::fragments_from_clusters(const std::vector<std::vector<uint>>& clusters, const cola::EventParticles& nucleons) {
  std::vector<cola::Particle*> fragments;

  for (uint i = 0; i < clusters.size(); ++i) {
    uint Z_clust = 0;
    uint A_clust = 0;
    cola::LorentzVector position = {0.0, 0.0, 0.0, 0.0};
    for (uint j = 0; j < clusters[i].size(); ++j) {
      std::cout << clusters[i][j] << " " << nucleons.size() << "\n";
      auto nucleon = &(nucleons.at(clusters[i][j]));
      position += nucleon->position;
      if (nucleon->getAZ().second == 1) {
        Z_clust += 1;
      }
      A_clust += 1;
    }

    cola::Particle* frag = new cola::Particle();
    frag->pdgCode = cola::AZToPdg({A_clust, Z_clust});
    frag->position = (position / double(A_clust));
    fragments.push_back(frag);
  }
  return fragments;
}

std::vector<std::vector<uint>> GMSTClustering::get_connected_components(double cd) {
  std::vector<std::vector<uint>> components;
  std::vector<bool> visited(tree.size(), false);

  for (size_t i = 0; i < tree.size(); ++i) {
    if (!visited[i]) {
      std::vector<uint> component;
      dfs(tree[i], visited, component, cd);
      components.push_back(component);
    }
  }
  return components;
}

void GMSTClustering::dfs(std::shared_ptr<Node> node, std::vector<bool>& visited, std::vector<uint>& component, double cd) {
  std::stack<std::shared_ptr<Node>> stack;
  stack.push(node);

  while (!stack.empty()) {
    auto current = stack.top();
    stack.pop();

    for (uint v : current->get_vertices()) {
      if (!visited[v]) {
        visited[v] = true;
        component.push_back(v);
      }
    }

    auto children = current->get_children();
    if (children.first && children.first->get_height() <= cd) {
      stack.push(children.first);
    }
    if (children.second && children.second->get_height() <= cd) {
      stack.push(children.second);
    }
  }
}

std::pair<double, double> GMSTClustering::get_exens() {
  auto ExEnA = std::make_unique<ExcitationEnergy>(stat_exen_type_, sourceA);
  auto ExEnB = std::make_unique<ExcitationEnergy>(stat_exen_type_, sourceAb);

  if (stat_exen_type_ > 2) {
    double e_0 = 11.5 * MeV;
    double sigma0 = 0.005;
    double b0 = 2;
    double sigmaE0 = 1 * MeV;
    double c0 = 0.1;
    double Pe = 24 * MeV;
    double Pm = 0.2;

    ExEnA->SetParametersALADIN(e_0, sigma0, b0);
    ExEnB->SetParametersALADIN(e_0, sigma0, b0);
    ExEnA->SetParametersParabolicApproximation(Pe, Pm, sigma0, c0, 0.01);
    ExEnB->SetParametersParabolicApproximation(Pe, Pm, sigma0, c0, 0.01);

    ExEnA->SetParametersHybridFit(11.46648905 * MeV, -1.84830078 * MeV, -58.53674677 * MeV, 284.66431513 * MeV, -637.51406293 * MeV, 652.80324427 * MeV, -251.28205381 * MeV, 0.4 * MeV, 0.5, 0.2);
    ExEnB->SetParametersHybridFit(11.46648905 * MeV, -1.84830078 * MeV, -58.53674677 * MeV, 284.66431513 * MeV, -637.51406293 * MeV, 652.80324427 * MeV, -251.28205381 * MeV, 0.4 * MeV, 0.5, 0.2);
  }

  double energy_A = ExEnA->GetEnergy(A);
  double energy_B = ExEnB->GetEnergy(Ab);

  return std::make_pair(energy_A, energy_B);
}

CLHEP::Hep3Vector GMSTClustering::get_boost(uint pZ, uint A) {
  CLHEP::HepLorentzVector boost_vec;
  if (A != 0) {
    double E = std::sqrt((pZ * pZ)/(A * A) + (nucleonAverMass * nucleonAverMass));
    CLHEP::HepLorentzVector futureBoost(0.0, 0.0, pZ / A, E);
    if (!futureBoost.isTimelike()) {
      std::cout << "Side" << " " << E << " nucl = " << A << std::endl;
    }
    boost_vec = futureBoost.boostVector();
  }
  else {
     boost_vec = CLHEP::Hep3Vector(0.0, 0.0, 0.0);
  }
  return boost_vec.boostVector();
}

cola::LorentzVector GMSTClustering::ToColaLorentzVector(G4LorentzVector lv) {
  cola::LorentzVector vec;
  vec.e = lv.e();
  vec.x = lv.x();
  vec.y = lv.y();
  vec.z = lv.z();
  return vec;
}