CMake_Minimum_Required(VERSION 4.0.0)

# Change name here 
Set(PROJECT_NAME bt_ecs)

Set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")

Project(${PROJECT_NAME} VERSION 0.0.1 LANGUAGES CXX)

option(${PROJECT_NAME}_STANDALONE "Build the project by itself" ON)
option(${PROJECT_NAME}_BUILD_TESTS "Build project tests" ON)

If (APPLE)
    Enable_Language(OBJCXX)
Endif ()

Set(CMAKE_CXX_STANDARD 23)
Set(CMAKE_CXX_STANDARD_REQUIRED ON)
Set(CMAKE_CXX_EXTENSIONS OFF)

Set(OUTPUT_DIR "${CMAKE_SOURCE_DIR}/bin/$<CONFIG>")
Set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR})
Set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${OUTPUT_DIR})

Include(CMake/funcs.cmake)
Include(CMake/deps.cmake)
Include(CMake/mods.cmake)

If(NOT ${${PROJECT_NAME}_STANDALONE})
    Include(CMake/examples.cmake)
Endif()

If(${${PROJECT_NAME}_BUILD_TESTS})
    Include(CMake/tests.cmake)
Endif()