@REM Creates the windows build files using VS26 build tools and generates all example projects

IF NOT EXIST "build" mkdir "build"
cd build

:: Change name here
cmake --preset "Windows Debug" -Dbt_template_STANDALONE=OFF ..\CMakeLists.txt

PAUSE