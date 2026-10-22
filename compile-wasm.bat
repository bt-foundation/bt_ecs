IF NOT EXIST "bin" mkdir "bin"
IF NOT EXIST "bin/wasm" mkdir "bin/wasm"

cmake --build build/wasm --target clean

cmake --build build/wasm

:: Change name of the input lib (by default it will be lib<project_name>.a where project name is set in CMakeLists.txt) and the output can be whatever-you-like.js
emcc -g build/wasm/libbt_template.a -o bin/wasm/bt_template.js

pause