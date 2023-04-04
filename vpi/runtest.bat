
rem VPI Test Compilation and Execution Script for Microsoft Windows Platforms

rem NOTE: This script is intended to be run in a DOS shell.

rem NOTE: The environment variable MTI_HOME must be set to point to your
rem       modeltech installation directory before invoking this script.
rem       Example: set MTI_HOME=\users\me\modeltech

set PLATFORM=win32

rem Visual C/C++ compilation
cl -c -I%MTI_HOME%\include vpi_test.c
link -dll -export:vlog_startup_routines vpi_test.obj %MTI_HOME%\win32\mtipli.lib

rm -rf work
%MTI_HOME%\%PLATFORM%\vlib work
%MTI_HOME%\%PLATFORM%\vlog prim.v dff.v top.v

%MTI_HOME%\%PLATFORM%\vsim -c -do vsim.do top -pli vpi_test.dll
