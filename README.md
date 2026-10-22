# bt_template - A template repository for the development of BiTurbo engine plugins and libraries

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
bt_template_STANDALONE // If set to "OFF" will build examples as well. Set to "ON" by default
bt_template_BUILD_TESTS // If set to "ON" will build tests as well. Set to "ON" by default
```

## Helper scripts

TODO

## How to use

1. Create a new repository with this repository as its template
2. Change the name of the project (there are 4 places - the root CMakeLists.txt, build-win.bat, build-wasm.bat, compile-wasm.bat and in build.yaml inside .github/workflows). Search for "Change name here" 
3. Add cpp files in src/private
4. Add hpp files in src/public
5. Build, compile and run with CMake and your generator of choice

### Dependencies

bt_template depends on [bt_core](https://github.com/bt-foundation/bt_core). To add more dependencies simply define them inside CMake/deps.cmake

```
CPMAddPackage(
    NAME dep_project_name
    GITHUB_REPOSITORY "account/project"
    GIT_TAG main # change to any branch you'd like
    OPTIONS "OPTION ON" # Custom CMake options
)
```

To keep it nice and clean inside a VS project you could also group it inside the Dependencies folder:

```
Set_Property(TARGET dep_project_name PROPERTY FOLDER "Dependencies")
```

Then you can link the new dependency to your project (inside CMake/mods.cmake):

```
Create_Module(
    NAME ${PROJECT_NAME}
    LANGUAGE CXX
    DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/src"
    DEPENDENCIES dep_project_name
    INCLUDE_DIRS "${bt_core_Include_Dir} ${dep_project_includes}"
)
```

### Examples

TODO

### Tests

TODO

### Notes

* By default when adding a module, the template exposes a variable in the format project_name_Include_Dirs, so if you'd like to use and include other projects from the bt_ ecosystem, you can easily do so.
* It is not recommended to modify the funcs.cmake if pulling in other libraries that define the same functions. Since dependency resolving comes before everything else, CMake will override the funcs with the ones added latest.

## TODO & Known issues:
* [ ] Easier setup - currently need to change the name of the project in 3 places (CMakeLists.txt, workflows and compile-wasm.bat). Ideally there could be a setup script to generate all of that (or just set an env variable) from a name input. FOR NOW: Search "Change Name" and change the name where the comments tell so!
* [ ] Building and running the windows tests through git actions does not detect any tests, but they are detected and ran fine locally through the batch scripts.
