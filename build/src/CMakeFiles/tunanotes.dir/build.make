# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.26

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

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
CMAKE_SOURCE_DIR = /home/tubbadu/code/Kirigami/TunaNotes

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/tubbadu/code/Kirigami/TunaNotes/build

# Include any dependencies generated for this target.
include src/CMakeFiles/tunanotes.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/CMakeFiles/tunanotes.dir/compiler_depend.make

# Include the progress variables for this target.
include src/CMakeFiles/tunanotes.dir/progress.make

# Include the compile flags for this target's objects.
include src/CMakeFiles/tunanotes.dir/flags.make

src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/resources.qrc
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: src/CMakeFiles/tunanotes_autogen.dir/AutoRcc_resources_EWIEGA46WW_Info.json
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/CheckBoxElement.qml
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/SyntaxNameField.qml
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/BlockTextEdit.qml
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/DotListElement.qml
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/IndentElement.qml
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/Clipboard.qml
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/syntaxDefinition.js
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/Document.qml
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/MouseAreaFunctions.js
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/keyHandler.js
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/blockFunctions.js
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/Block.qml
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/parser.js
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/QuoteElement.qml
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /home/tubbadu/code/Kirigami/TunaNotes/src/contents/ui/main.qml
src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp: /usr/lib64/qt5/bin/rcc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/tubbadu/code/Kirigami/TunaNotes/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Automatic RCC for resources.qrc"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/cmake -E cmake_autorcc /home/tubbadu/code/Kirigami/TunaNotes/build/src/CMakeFiles/tunanotes_autogen.dir/AutoRcc_resources_EWIEGA46WW_Info.json Debug

src/CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.o: src/CMakeFiles/tunanotes.dir/flags.make
src/CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.o: src/tunanotes_autogen/mocs_compilation.cpp
src/CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.o: src/CMakeFiles/tunanotes.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tubbadu/code/Kirigami/TunaNotes/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object src/CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.o"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.o -MF CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.o.d -o CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.o -c /home/tubbadu/code/Kirigami/TunaNotes/build/src/tunanotes_autogen/mocs_compilation.cpp

src/CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.i"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/tubbadu/code/Kirigami/TunaNotes/build/src/tunanotes_autogen/mocs_compilation.cpp > CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.i

src/CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.s"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/tubbadu/code/Kirigami/TunaNotes/build/src/tunanotes_autogen/mocs_compilation.cpp -o CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.s

src/CMakeFiles/tunanotes.dir/main.cpp.o: src/CMakeFiles/tunanotes.dir/flags.make
src/CMakeFiles/tunanotes.dir/main.cpp.o: /home/tubbadu/code/Kirigami/TunaNotes/src/main.cpp
src/CMakeFiles/tunanotes.dir/main.cpp.o: src/CMakeFiles/tunanotes.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tubbadu/code/Kirigami/TunaNotes/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object src/CMakeFiles/tunanotes.dir/main.cpp.o"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/CMakeFiles/tunanotes.dir/main.cpp.o -MF CMakeFiles/tunanotes.dir/main.cpp.o.d -o CMakeFiles/tunanotes.dir/main.cpp.o -c /home/tubbadu/code/Kirigami/TunaNotes/src/main.cpp

src/CMakeFiles/tunanotes.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tunanotes.dir/main.cpp.i"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/tubbadu/code/Kirigami/TunaNotes/src/main.cpp > CMakeFiles/tunanotes.dir/main.cpp.i

src/CMakeFiles/tunanotes.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tunanotes.dir/main.cpp.s"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/tubbadu/code/Kirigami/TunaNotes/src/main.cpp -o CMakeFiles/tunanotes.dir/main.cpp.s

src/CMakeFiles/tunanotes.dir/launcher.cpp.o: src/CMakeFiles/tunanotes.dir/flags.make
src/CMakeFiles/tunanotes.dir/launcher.cpp.o: /home/tubbadu/code/Kirigami/TunaNotes/src/launcher.cpp
src/CMakeFiles/tunanotes.dir/launcher.cpp.o: src/CMakeFiles/tunanotes.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tubbadu/code/Kirigami/TunaNotes/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object src/CMakeFiles/tunanotes.dir/launcher.cpp.o"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/CMakeFiles/tunanotes.dir/launcher.cpp.o -MF CMakeFiles/tunanotes.dir/launcher.cpp.o.d -o CMakeFiles/tunanotes.dir/launcher.cpp.o -c /home/tubbadu/code/Kirigami/TunaNotes/src/launcher.cpp

src/CMakeFiles/tunanotes.dir/launcher.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tunanotes.dir/launcher.cpp.i"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/tubbadu/code/Kirigami/TunaNotes/src/launcher.cpp > CMakeFiles/tunanotes.dir/launcher.cpp.i

src/CMakeFiles/tunanotes.dir/launcher.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tunanotes.dir/launcher.cpp.s"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/tubbadu/code/Kirigami/TunaNotes/src/launcher.cpp -o CMakeFiles/tunanotes.dir/launcher.cpp.s

src/CMakeFiles/tunanotes.dir/fileManager.cpp.o: src/CMakeFiles/tunanotes.dir/flags.make
src/CMakeFiles/tunanotes.dir/fileManager.cpp.o: /home/tubbadu/code/Kirigami/TunaNotes/src/fileManager.cpp
src/CMakeFiles/tunanotes.dir/fileManager.cpp.o: src/CMakeFiles/tunanotes.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tubbadu/code/Kirigami/TunaNotes/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object src/CMakeFiles/tunanotes.dir/fileManager.cpp.o"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/CMakeFiles/tunanotes.dir/fileManager.cpp.o -MF CMakeFiles/tunanotes.dir/fileManager.cpp.o.d -o CMakeFiles/tunanotes.dir/fileManager.cpp.o -c /home/tubbadu/code/Kirigami/TunaNotes/src/fileManager.cpp

src/CMakeFiles/tunanotes.dir/fileManager.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tunanotes.dir/fileManager.cpp.i"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/tubbadu/code/Kirigami/TunaNotes/src/fileManager.cpp > CMakeFiles/tunanotes.dir/fileManager.cpp.i

src/CMakeFiles/tunanotes.dir/fileManager.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tunanotes.dir/fileManager.cpp.s"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/tubbadu/code/Kirigami/TunaNotes/src/fileManager.cpp -o CMakeFiles/tunanotes.dir/fileManager.cpp.s

src/CMakeFiles/tunanotes.dir/plainTextFormat.cpp.o: src/CMakeFiles/tunanotes.dir/flags.make
src/CMakeFiles/tunanotes.dir/plainTextFormat.cpp.o: /home/tubbadu/code/Kirigami/TunaNotes/src/plainTextFormat.cpp
src/CMakeFiles/tunanotes.dir/plainTextFormat.cpp.o: src/CMakeFiles/tunanotes.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tubbadu/code/Kirigami/TunaNotes/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object src/CMakeFiles/tunanotes.dir/plainTextFormat.cpp.o"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/CMakeFiles/tunanotes.dir/plainTextFormat.cpp.o -MF CMakeFiles/tunanotes.dir/plainTextFormat.cpp.o.d -o CMakeFiles/tunanotes.dir/plainTextFormat.cpp.o -c /home/tubbadu/code/Kirigami/TunaNotes/src/plainTextFormat.cpp

src/CMakeFiles/tunanotes.dir/plainTextFormat.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tunanotes.dir/plainTextFormat.cpp.i"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/tubbadu/code/Kirigami/TunaNotes/src/plainTextFormat.cpp > CMakeFiles/tunanotes.dir/plainTextFormat.cpp.i

src/CMakeFiles/tunanotes.dir/plainTextFormat.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tunanotes.dir/plainTextFormat.cpp.s"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/tubbadu/code/Kirigami/TunaNotes/src/plainTextFormat.cpp -o CMakeFiles/tunanotes.dir/plainTextFormat.cpp.s

src/CMakeFiles/tunanotes.dir/Highlighter.cpp.o: src/CMakeFiles/tunanotes.dir/flags.make
src/CMakeFiles/tunanotes.dir/Highlighter.cpp.o: /home/tubbadu/code/Kirigami/TunaNotes/src/Highlighter.cpp
src/CMakeFiles/tunanotes.dir/Highlighter.cpp.o: src/CMakeFiles/tunanotes.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tubbadu/code/Kirigami/TunaNotes/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object src/CMakeFiles/tunanotes.dir/Highlighter.cpp.o"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/CMakeFiles/tunanotes.dir/Highlighter.cpp.o -MF CMakeFiles/tunanotes.dir/Highlighter.cpp.o.d -o CMakeFiles/tunanotes.dir/Highlighter.cpp.o -c /home/tubbadu/code/Kirigami/TunaNotes/src/Highlighter.cpp

src/CMakeFiles/tunanotes.dir/Highlighter.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tunanotes.dir/Highlighter.cpp.i"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/tubbadu/code/Kirigami/TunaNotes/src/Highlighter.cpp > CMakeFiles/tunanotes.dir/Highlighter.cpp.i

src/CMakeFiles/tunanotes.dir/Highlighter.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tunanotes.dir/Highlighter.cpp.s"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/tubbadu/code/Kirigami/TunaNotes/src/Highlighter.cpp -o CMakeFiles/tunanotes.dir/Highlighter.cpp.s

src/CMakeFiles/tunanotes.dir/DBusReceiver.cpp.o: src/CMakeFiles/tunanotes.dir/flags.make
src/CMakeFiles/tunanotes.dir/DBusReceiver.cpp.o: /home/tubbadu/code/Kirigami/TunaNotes/src/DBusReceiver.cpp
src/CMakeFiles/tunanotes.dir/DBusReceiver.cpp.o: src/CMakeFiles/tunanotes.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tubbadu/code/Kirigami/TunaNotes/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object src/CMakeFiles/tunanotes.dir/DBusReceiver.cpp.o"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/CMakeFiles/tunanotes.dir/DBusReceiver.cpp.o -MF CMakeFiles/tunanotes.dir/DBusReceiver.cpp.o.d -o CMakeFiles/tunanotes.dir/DBusReceiver.cpp.o -c /home/tubbadu/code/Kirigami/TunaNotes/src/DBusReceiver.cpp

src/CMakeFiles/tunanotes.dir/DBusReceiver.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tunanotes.dir/DBusReceiver.cpp.i"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/tubbadu/code/Kirigami/TunaNotes/src/DBusReceiver.cpp > CMakeFiles/tunanotes.dir/DBusReceiver.cpp.i

src/CMakeFiles/tunanotes.dir/DBusReceiver.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tunanotes.dir/DBusReceiver.cpp.s"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/tubbadu/code/Kirigami/TunaNotes/src/DBusReceiver.cpp -o CMakeFiles/tunanotes.dir/DBusReceiver.cpp.s

src/CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.o: src/CMakeFiles/tunanotes.dir/flags.make
src/CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.o: src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp
src/CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.o: src/CMakeFiles/tunanotes.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tubbadu/code/Kirigami/TunaNotes/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building CXX object src/CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.o"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.o -MF CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.o.d -o CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.o -c /home/tubbadu/code/Kirigami/TunaNotes/build/src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp

src/CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.i"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/tubbadu/code/Kirigami/TunaNotes/build/src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp > CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.i

src/CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.s"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/tubbadu/code/Kirigami/TunaNotes/build/src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp -o CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.s

# Object files for target tunanotes
tunanotes_OBJECTS = \
"CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.o" \
"CMakeFiles/tunanotes.dir/main.cpp.o" \
"CMakeFiles/tunanotes.dir/launcher.cpp.o" \
"CMakeFiles/tunanotes.dir/fileManager.cpp.o" \
"CMakeFiles/tunanotes.dir/plainTextFormat.cpp.o" \
"CMakeFiles/tunanotes.dir/Highlighter.cpp.o" \
"CMakeFiles/tunanotes.dir/DBusReceiver.cpp.o" \
"CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.o"

# External object files for target tunanotes
tunanotes_EXTERNAL_OBJECTS =

bin/tunanotes: src/CMakeFiles/tunanotes.dir/tunanotes_autogen/mocs_compilation.cpp.o
bin/tunanotes: src/CMakeFiles/tunanotes.dir/main.cpp.o
bin/tunanotes: src/CMakeFiles/tunanotes.dir/launcher.cpp.o
bin/tunanotes: src/CMakeFiles/tunanotes.dir/fileManager.cpp.o
bin/tunanotes: src/CMakeFiles/tunanotes.dir/plainTextFormat.cpp.o
bin/tunanotes: src/CMakeFiles/tunanotes.dir/Highlighter.cpp.o
bin/tunanotes: src/CMakeFiles/tunanotes.dir/DBusReceiver.cpp.o
bin/tunanotes: src/CMakeFiles/tunanotes.dir/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp.o
bin/tunanotes: src/CMakeFiles/tunanotes.dir/build.make
bin/tunanotes: src/CMakeFiles/tunanotes.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/tubbadu/code/Kirigami/TunaNotes/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Linking CXX executable ../bin/tunanotes"
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/tunanotes.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/CMakeFiles/tunanotes.dir/build: bin/tunanotes
.PHONY : src/CMakeFiles/tunanotes.dir/build

src/CMakeFiles/tunanotes.dir/clean:
	cd /home/tubbadu/code/Kirigami/TunaNotes/build/src && $(CMAKE_COMMAND) -P CMakeFiles/tunanotes.dir/cmake_clean.cmake
.PHONY : src/CMakeFiles/tunanotes.dir/clean

src/CMakeFiles/tunanotes.dir/depend: src/tunanotes_autogen/EWIEGA46WW/qrc_resources.cpp
	cd /home/tubbadu/code/Kirigami/TunaNotes/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tubbadu/code/Kirigami/TunaNotes /home/tubbadu/code/Kirigami/TunaNotes/src /home/tubbadu/code/Kirigami/TunaNotes/build /home/tubbadu/code/Kirigami/TunaNotes/build/src /home/tubbadu/code/Kirigami/TunaNotes/build/src/CMakeFiles/tunanotes.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/tunanotes.dir/depend

