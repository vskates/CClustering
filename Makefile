# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.28

# Default target executed when no arguments are given to make.
default_target: all
.PHONY : default_target

# Allow only one "make -f Makefile2" at a time, but pass parallelism.
.NOTPARALLEL:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ekaterina/Документы/CClustering

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ekaterina/Документы/CClustering

#=============================================================================
# Targets provided globally by CMake.

# Special rule for the target edit_cache
edit_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --cyan "No interactive CMake dialog available..."
	/usr/bin/cmake -E echo No\ interactive\ CMake\ dialog\ available.
.PHONY : edit_cache

# Special rule for the target edit_cache
edit_cache/fast: edit_cache
.PHONY : edit_cache/fast

# Special rule for the target rebuild_cache
rebuild_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --cyan "Running CMake to regenerate build system..."
	/usr/bin/cmake --regenerate-during-build -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : rebuild_cache

# Special rule for the target rebuild_cache
rebuild_cache/fast: rebuild_cache
.PHONY : rebuild_cache/fast

# Special rule for the target list_install_components
list_install_components:
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --cyan "Available install components are: \"Unspecified\""
.PHONY : list_install_components

# Special rule for the target list_install_components
list_install_components/fast: list_install_components
.PHONY : list_install_components/fast

# Special rule for the target install
install: preinstall
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --cyan "Install the project..."
	/usr/bin/cmake -P cmake_install.cmake
.PHONY : install

# Special rule for the target install
install/fast: preinstall/fast
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --cyan "Install the project..."
	/usr/bin/cmake -P cmake_install.cmake
.PHONY : install/fast

# Special rule for the target install/local
install/local: preinstall
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --cyan "Installing only the local directory..."
	/usr/bin/cmake -DCMAKE_INSTALL_LOCAL_ONLY=1 -P cmake_install.cmake
.PHONY : install/local

# Special rule for the target install/local
install/local/fast: preinstall/fast
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --cyan "Installing only the local directory..."
	/usr/bin/cmake -DCMAKE_INSTALL_LOCAL_ONLY=1 -P cmake_install.cmake
.PHONY : install/local/fast

# Special rule for the target install/strip
install/strip: preinstall
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --cyan "Installing the project stripped..."
	/usr/bin/cmake -DCMAKE_INSTALL_DO_STRIP=1 -P cmake_install.cmake
.PHONY : install/strip

# Special rule for the target install/strip
install/strip/fast: preinstall/fast
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --cyan "Installing the project stripped..."
	/usr/bin/cmake -DCMAKE_INSTALL_DO_STRIP=1 -P cmake_install.cmake
.PHONY : install/strip/fast

# The main all target
all: cmake_check_build_system
	$(CMAKE_COMMAND) -E cmake_progress_start /home/ekaterina/Документы/CClustering/CMakeFiles /home/ekaterina/Документы/CClustering//CMakeFiles/progress.marks
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 all
	$(CMAKE_COMMAND) -E cmake_progress_start /home/ekaterina/Документы/CClustering/CMakeFiles 0
.PHONY : all

# The main clean target
clean:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 clean
.PHONY : clean

# The main clean target
clean/fast: clean
.PHONY : clean/fast

# Prepare targets for installation.
preinstall: all
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall

# Prepare targets for installation.
preinstall/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall/fast

# clear depends
depend:
	$(CMAKE_COMMAND) -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 1
.PHONY : depend

#=============================================================================
# Target rules for targets named CClustering

# Build rule for target.
CClustering: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 CClustering
.PHONY : CClustering

# fast build rule for target.
CClustering/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/build
.PHONY : CClustering/fast

ExcitationEnergy/Ericson.o: ExcitationEnergy/Ericson.cc.o
.PHONY : ExcitationEnergy/Ericson.o

# target to build an object file
ExcitationEnergy/Ericson.cc.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/ExcitationEnergy/Ericson.cc.o
.PHONY : ExcitationEnergy/Ericson.cc.o

ExcitationEnergy/Ericson.i: ExcitationEnergy/Ericson.cc.i
.PHONY : ExcitationEnergy/Ericson.i

# target to preprocess a source file
ExcitationEnergy/Ericson.cc.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/ExcitationEnergy/Ericson.cc.i
.PHONY : ExcitationEnergy/Ericson.cc.i

ExcitationEnergy/Ericson.s: ExcitationEnergy/Ericson.cc.s
.PHONY : ExcitationEnergy/Ericson.s

# target to generate assembly for a file
ExcitationEnergy/Ericson.cc.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/ExcitationEnergy/Ericson.cc.s
.PHONY : ExcitationEnergy/Ericson.cc.s

ExcitationEnergy/ExcitationEnergy.o: ExcitationEnergy/ExcitationEnergy.cc.o
.PHONY : ExcitationEnergy/ExcitationEnergy.o

# target to build an object file
ExcitationEnergy/ExcitationEnergy.cc.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/ExcitationEnergy/ExcitationEnergy.cc.o
.PHONY : ExcitationEnergy/ExcitationEnergy.cc.o

ExcitationEnergy/ExcitationEnergy.i: ExcitationEnergy/ExcitationEnergy.cc.i
.PHONY : ExcitationEnergy/ExcitationEnergy.i

# target to preprocess a source file
ExcitationEnergy/ExcitationEnergy.cc.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/ExcitationEnergy/ExcitationEnergy.cc.i
.PHONY : ExcitationEnergy/ExcitationEnergy.cc.i

ExcitationEnergy/ExcitationEnergy.s: ExcitationEnergy/ExcitationEnergy.cc.s
.PHONY : ExcitationEnergy/ExcitationEnergy.s

# target to generate assembly for a file
ExcitationEnergy/ExcitationEnergy.cc.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/ExcitationEnergy/ExcitationEnergy.cc.s
.PHONY : ExcitationEnergy/ExcitationEnergy.cc.s

ExcitationEnergy/GaimardSchmidt.o: ExcitationEnergy/GaimardSchmidt.cc.o
.PHONY : ExcitationEnergy/GaimardSchmidt.o

# target to build an object file
ExcitationEnergy/GaimardSchmidt.cc.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/ExcitationEnergy/GaimardSchmidt.cc.o
.PHONY : ExcitationEnergy/GaimardSchmidt.cc.o

ExcitationEnergy/GaimardSchmidt.i: ExcitationEnergy/GaimardSchmidt.cc.i
.PHONY : ExcitationEnergy/GaimardSchmidt.i

# target to preprocess a source file
ExcitationEnergy/GaimardSchmidt.cc.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/ExcitationEnergy/GaimardSchmidt.cc.i
.PHONY : ExcitationEnergy/GaimardSchmidt.cc.i

ExcitationEnergy/GaimardSchmidt.s: ExcitationEnergy/GaimardSchmidt.cc.s
.PHONY : ExcitationEnergy/GaimardSchmidt.s

# target to generate assembly for a file
ExcitationEnergy/GaimardSchmidt.cc.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/ExcitationEnergy/GaimardSchmidt.cc.s
.PHONY : ExcitationEnergy/GaimardSchmidt.cc.s

MST/MSTClustering.o: MST/MSTClustering.cc.o
.PHONY : MST/MSTClustering.o

# target to build an object file
MST/MSTClustering.cc.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/MST/MSTClustering.cc.o
.PHONY : MST/MSTClustering.cc.o

MST/MSTClustering.i: MST/MSTClustering.cc.i
.PHONY : MST/MSTClustering.i

# target to preprocess a source file
MST/MSTClustering.cc.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/MST/MSTClustering.cc.i
.PHONY : MST/MSTClustering.cc.i

MST/MSTClustering.s: MST/MSTClustering.cc.s
.PHONY : MST/MSTClustering.s

# target to generate assembly for a file
MST/MSTClustering.cc.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/MST/MSTClustering.cc.s
.PHONY : MST/MSTClustering.cc.s

RepulsionStage/Repulsion.o: RepulsionStage/Repulsion.cc.o
.PHONY : RepulsionStage/Repulsion.o

# target to build an object file
RepulsionStage/Repulsion.cc.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/RepulsionStage/Repulsion.cc.o
.PHONY : RepulsionStage/Repulsion.cc.o

RepulsionStage/Repulsion.i: RepulsionStage/Repulsion.cc.i
.PHONY : RepulsionStage/Repulsion.i

# target to preprocess a source file
RepulsionStage/Repulsion.cc.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/RepulsionStage/Repulsion.cc.i
.PHONY : RepulsionStage/Repulsion.cc.i

RepulsionStage/Repulsion.s: RepulsionStage/Repulsion.cc.s
.PHONY : RepulsionStage/Repulsion.s

# target to generate assembly for a file
RepulsionStage/Repulsion.cc.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/RepulsionStage/Repulsion.cc.s
.PHONY : RepulsionStage/Repulsion.cc.s

Wrapper/CClusteringFactory.o: Wrapper/CClusteringFactory.cc.o
.PHONY : Wrapper/CClusteringFactory.o

# target to build an object file
Wrapper/CClusteringFactory.cc.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/Wrapper/CClusteringFactory.cc.o
.PHONY : Wrapper/CClusteringFactory.cc.o

Wrapper/CClusteringFactory.i: Wrapper/CClusteringFactory.cc.i
.PHONY : Wrapper/CClusteringFactory.i

# target to preprocess a source file
Wrapper/CClusteringFactory.cc.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/Wrapper/CClusteringFactory.cc.i
.PHONY : Wrapper/CClusteringFactory.cc.i

Wrapper/CClusteringFactory.s: Wrapper/CClusteringFactory.cc.s
.PHONY : Wrapper/CClusteringFactory.s

# target to generate assembly for a file
Wrapper/CClusteringFactory.cc.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/CClustering.dir/build.make CMakeFiles/CClustering.dir/Wrapper/CClusteringFactory.cc.s
.PHONY : Wrapper/CClusteringFactory.cc.s

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... depend"
	@echo "... edit_cache"
	@echo "... install"
	@echo "... install/local"
	@echo "... install/strip"
	@echo "... list_install_components"
	@echo "... rebuild_cache"
	@echo "... CClustering"
	@echo "... ExcitationEnergy/Ericson.o"
	@echo "... ExcitationEnergy/Ericson.i"
	@echo "... ExcitationEnergy/Ericson.s"
	@echo "... ExcitationEnergy/ExcitationEnergy.o"
	@echo "... ExcitationEnergy/ExcitationEnergy.i"
	@echo "... ExcitationEnergy/ExcitationEnergy.s"
	@echo "... ExcitationEnergy/GaimardSchmidt.o"
	@echo "... ExcitationEnergy/GaimardSchmidt.i"
	@echo "... ExcitationEnergy/GaimardSchmidt.s"
	@echo "... MST/MSTClustering.o"
	@echo "... MST/MSTClustering.i"
	@echo "... MST/MSTClustering.s"
	@echo "... RepulsionStage/Repulsion.o"
	@echo "... RepulsionStage/Repulsion.i"
	@echo "... RepulsionStage/Repulsion.s"
	@echo "... Wrapper/CClusteringFactory.o"
	@echo "... Wrapper/CClusteringFactory.i"
	@echo "... Wrapper/CClusteringFactory.s"
.PHONY : help



#=============================================================================
# Special targets to cleanup operation of make.

# Special rule to run CMake to check the build system integrity.
# No rule that depends on this can have commands that come from listfiles
# because they might be regenerated.
cmake_check_build_system:
	$(CMAKE_COMMAND) -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 0
.PHONY : cmake_check_build_system

