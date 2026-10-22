@REM Creates the windows build files using VS26 build tools and generates all example projects

IF NOT EXIST "build" mkdir "build"
cd build

:: Change name here
cmake --preset "Windows Debug" -Dbt_ecs_STANDALONE=OFF -DCPM_SOURCE_CACHE=.cache ..\CMakeLists.txt

PAUSE