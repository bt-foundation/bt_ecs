# Includes CPM to easily pull repositories for external dependencies
if (NOT EXISTS "${CMAKE_BINARY_DIR}/cmake/CPM.cmake")
    Message(STATUS "Downloading CPM.cmake to ${CMAKE_BINARY_DIR}/cmake")
    File(DOWNLOAD
        "https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.42.1/CPM.cmake"
        "${CMAKE_BINARY_DIR}/cmake/CPM.cmake"
        EXPECTED_HASH SHA256=f3a6dcc6a04ce9e7f51a127307fa4f699fb2bade357a8eb4c5b45df76e1dc6a5
    )
endif ()
Include("${CMAKE_BINARY_DIR}/cmake/CPM.cmake")

CPMAddPackage(
    NAME bt_core
    GITHUB_REPOSITORY "bt-foundation/bt_core"
    GIT_TAG dev # change to any branch you'd like
    OPTIONS "BT_STANDALONE ON" # Custom CMake options
)
Set_Property(TARGET bt_core PROPERTY FOLDER "Dependencies")

If(${${PROJECT_NAME}_BUILD_TESTS})
    enable_testing()

    CPMAddPackage(
        NAME gtest
        GITHUB_REPOSITORY "google/googletest"
        GIT_TAG main
    )
    Set_Property(TARGET gtest PROPERTY FOLDER "Dependencies")
    Set_Property(TARGET gtest_main PROPERTY FOLDER "Dependencies")
    Set_Property(TARGET gmock PROPERTY FOLDER "Dependencies")
    Set_Property(TARGET gmock_main PROPERTY FOLDER "Dependencies")
Endif()