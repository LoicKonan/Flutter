# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
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
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /var/www/AGsoft/BackEnd/app/CPP_DIRECTORY/1017/fowzy/P04/CPP_DIRECTORY/1017/fowzy/P04

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /var/www/AGsoft/BackEnd/app/CPP_DIRECTORY/1017/fowzy/P04/CPP_DIRECTORY/1017/fowzy/P04

# Include any dependencies generated for this target.
include CMakeFiles/1017_fowzy.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/1017_fowzy.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/1017_fowzy.dir/flags.make

CMakeFiles/1017_fowzy.dir/cs1.cpp.o: CMakeFiles/1017_fowzy.dir/flags.make
CMakeFiles/1017_fowzy.dir/cs1.cpp.o: cs1.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/var/www/AGsoft/BackEnd/app/CPP_DIRECTORY/1017/fowzy/P04/CPP_DIRECTORY/1017/fowzy/P04/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/1017_fowzy.dir/cs1.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/1017_fowzy.dir/cs1.cpp.o -c /var/www/AGsoft/BackEnd/app/CPP_DIRECTORY/1017/fowzy/P04/CPP_DIRECTORY/1017/fowzy/P04/cs1.cpp

CMakeFiles/1017_fowzy.dir/cs1.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/1017_fowzy.dir/cs1.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /var/www/AGsoft/BackEnd/app/CPP_DIRECTORY/1017/fowzy/P04/CPP_DIRECTORY/1017/fowzy/P04/cs1.cpp > CMakeFiles/1017_fowzy.dir/cs1.cpp.i

CMakeFiles/1017_fowzy.dir/cs1.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/1017_fowzy.dir/cs1.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /var/www/AGsoft/BackEnd/app/CPP_DIRECTORY/1017/fowzy/P04/CPP_DIRECTORY/1017/fowzy/P04/cs1.cpp -o CMakeFiles/1017_fowzy.dir/cs1.cpp.s

# Object files for target 1017_fowzy
1017_fowzy_OBJECTS = \
"CMakeFiles/1017_fowzy.dir/cs1.cpp.o"

# External object files for target 1017_fowzy
1017_fowzy_EXTERNAL_OBJECTS =

1017_fowzy: CMakeFiles/1017_fowzy.dir/cs1.cpp.o
1017_fowzy: CMakeFiles/1017_fowzy.dir/build.make
1017_fowzy: CMakeFiles/1017_fowzy.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/var/www/AGsoft/BackEnd/app/CPP_DIRECTORY/1017/fowzy/P04/CPP_DIRECTORY/1017/fowzy/P04/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable 1017_fowzy"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/1017_fowzy.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/1017_fowzy.dir/build: 1017_fowzy

.PHONY : CMakeFiles/1017_fowzy.dir/build

CMakeFiles/1017_fowzy.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/1017_fowzy.dir/cmake_clean.cmake
.PHONY : CMakeFiles/1017_fowzy.dir/clean

CMakeFiles/1017_fowzy.dir/depend:
	cd /var/www/AGsoft/BackEnd/app/CPP_DIRECTORY/1017/fowzy/P04/CPP_DIRECTORY/1017/fowzy/P04 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /var/www/AGsoft/BackEnd/app/CPP_DIRECTORY/1017/fowzy/P04/CPP_DIRECTORY/1017/fowzy/P04 /var/www/AGsoft/BackEnd/app/CPP_DIRECTORY/1017/fowzy/P04/CPP_DIRECTORY/1017/fowzy/P04 /var/www/AGsoft/BackEnd/app/CPP_DIRECTORY/1017/fowzy/P04/CPP_DIRECTORY/1017/fowzy/P04 /var/www/AGsoft/BackEnd/app/CPP_DIRECTORY/1017/fowzy/P04/CPP_DIRECTORY/1017/fowzy/P04 /var/www/AGsoft/BackEnd/app/CPP_DIRECTORY/1017/fowzy/P04/CPP_DIRECTORY/1017/fowzy/P04/CMakeFiles/1017_fowzy.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/1017_fowzy.dir/depend

