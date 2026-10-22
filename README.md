# bt_ecs - A powerful, multi-threaded Entity Component System, serving as the backbone of BiTurbo engine 

## Requirements

* `CMake`
* `Build generator of choice (VS or Ninja or whichever CMake supports)`
* `Emscripten` for WASM builds 

## Folder structure

```
├───.github
│   └───workflows
├───bin \\ generated
│   ├───Debug
│   └───Release
├───build \\ generated
│   ├───wasm
│   └───win64
├───CMake
├───examples
├───src
│   ├───private
│   └───public
└───tests
```

## Building

The project uses CMake as it's build system. To create a build for it simply run CMake in the terminal from the root of the project's directory:

```batch
cmake --preset <Preset of choice> -B build
```

There are a couple of presets available (from CMakePresets.json):

Operating systems: Linux, Windows, MacOS

Configuration types: Debug, Release

And for Windows you can simply:

```batch
cmake --preset "Windows Debug" -B build
```

Note: the Debug vs Release only matters for single-target generators (like Makefiles or Ninja on Linux). Visual Studio generator will either way build a project capable of building and running all available configurations. 

---
Some additional options:

```
bt_ecs_STANDALONE // If set to "OFF" will build examples as well. Set to "ON" by default
bt_ecs_BUILD_TESTS // If set to "ON" will build tests as well. Set to "ON" by default
```

## API & Docs

TODO
