Function(create_example)
    Set(options "")
    Set(oneValueArgs NAME MODULE DIRECTORY)
    Set(multiValueArgs DEPENDENCIES INCLUDE_DIRS)

    CMake_Parse_Arguments(EXAMPLE "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if (NOT EXAMPLE_NAME OR NOT EXAMPLE_DIRECTORY)
        Message(FATAL_ERROR "create_example requires a valid NAME, MODULE and DIRECTORY.")
    endif ()
    
    message("-- Creating Example --")
    message("Example name: ${EXAMPLE_NAME}")
    message("Example include dirs: ${EXAMPLE_INCLUDE_DIRS}")
    message("Example dir: ${EXAMPLE_DIRECTORY}")
    message("Example deps: ${EXAMPLE_DEPENDENCIES}")
    message("")

    File(GLOB_RECURSE EXAMPLE_FILES "${EXAMPLE_DIRECTORY}/*.cpp")

    Add_Executable(${EXAMPLE_NAME} ${EXAMPLE_FILES})
    
    Set_Property(TARGET ${EXAMPLE_NAME} PROPERTY FOLDER "Examples")

    Set_Target_Properties(${EXAMPLE_NAME} PROPERTIES LINKER_LANGUAGE CXX)
    Target_Link_Libraries(${EXAMPLE_NAME} PRIVATE ${EXAMPLE_DEPENDENCIES})
    Target_Include_Directories(${EXAMPLE_NAME} PUBLIC "${EXAMPLE_DIRECTORY}" "${EXAMPLE_INCLUDE_DIRS}" PRIVATE "${EXAMPLE_DIRECTORY}")

EndFunction()

Function(create_module)
    Set(options "")
    Set(oneValueArgs NAME DIRECTORY LANGUAGE)
    Set(multiValueArgs DEPENDENCIES INCLUDE_DIRS)

    CMake_Parse_Arguments(MODULE "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if (NOT MODULE_NAME OR NOT MODULE_DIRECTORY OR NOT MODULE_LANGUAGE)
        Message(FATAL_ERROR "create_module requires a valid NAME, DIRECTORY and LANGUAGE.")
    endif ()

    message("-- Creating Module --")
    message("Module name: ${MODULE_NAME}")
    message("Module include dirs: ${MODULE_INCLUDE_DIRS}")
    message("Module dir: ${MODULE_DIRECTORY}")
    message("Module deps: ${MODULE_DEPENDENCIES}")
    message("")
    
    File(GLOB_RECURSE MODULE_FILES "${MODULE_DIRECTORY}/public/*.hpp" "${MODULE_DIRECTORY}/private/*.cpp" "${MODULE_DIRECTORY}/*.mm")

    Add_Library(${MODULE_NAME} STATIC ${MODULE_FILES})

    Set_Property(TARGET ${MODULE_NAME} PROPERTY FOLDER "Libs")

    Set_Target_Properties(${MODULE_NAME} PROPERTIES LINKER_LANGUAGE ${MODULE_LANGUAGE})
    Target_Link_Libraries(${MODULE_NAME} PUBLIC ${MODULE_DEPENDENCIES})
    Target_Include_Directories(${MODULE_NAME} PUBLIC "${MODULE_DIRECTORY}/public" PUBLIC "${MODULE_INCLUDE_DIRS}" PRIVATE "${MODULE_DIRECTORY}/private")
    Set(${MODULE_NAME}_Include_Dir "${MODULE_DIRECTORY}/public" PARENT_SCOPE)
EndFunction()

Function(create_interface)
    Set(options "")
    Set(oneValueArgs NAME DIRECTORY LANGUAGE)
    Set(multiValueArgs DEPENDENCIES)

    CMake_Parse_Arguments(MODULE "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if (NOT MODULE_NAME OR NOT MODULE_DIRECTORY OR NOT MODULE_LANGUAGE)
        Message(FATAL_ERROR "create_interface requires a valid NAME, DIRECTORY and LANGUAGE.")
    endif ()

    File(GLOB_RECURSE MODULE_FILES "${MODULE_DIRECTORY}/*.hpp")

    Add_Library(${MODULE_NAME} INTERFACE ${MODULE_FILES})

    Set_Property(TARGET ${MODULE_NAME} PROPERTY FOLDER "Libs")

    Set_Target_Properties(${MODULE_NAME} PROPERTIES LINKER_LANGUAGE ${MODULE_LANGUAGE})
    Target_Link_Libraries(${MODULE_NAME} INTERFACE ${MODULE_DEPENDENCIES})
    Target_Include_Directories(${MODULE_NAME} INTERFACE "${MODULE_DIRECTORY}/public")
EndFunction()

Function(create_test)
    Set(options "")
    Set(oneValueArgs NAME MODULE DIRECTORY)
    Set(multiValueArgs DEPENDENCIES INCLUDE_DIRS)

    CMake_Parse_Arguments(TEST "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if (NOT TEST_NAME OR NOT TEST_DIRECTORY)
        Message(FATAL_ERROR "create_test requires a valid NAME, MODULE and DIRECTORY.")
    endif ()
    
    message("-- Creating Test --")
    message("Test name: ${TEST_NAME}")
    message("Test include dirs: ${TEST_INCLUDE_DIRS}")
    message("Test dir: ${TEST_DIRECTORY}")
    message("Test deps: ${TEST_DEPENDENCIES}")
    message("")

    File(GLOB_RECURSE TEST_FILES "${TEST_DIRECTORY}/*.cpp")

    Add_Executable(${TEST_NAME} ${TEST_FILES})

    Set_Property(TARGET ${TEST_NAME} PROPERTY FOLDER "Tests")

    Set_Target_Properties(${TEST_NAME} PROPERTIES LINKER_LANGUAGE CXX)
    Target_Link_Libraries(${TEST_NAME} PRIVATE ${TEST_DEPENDENCIES} GTest::gtest_main)
    Target_Include_Directories(${TEST_NAME} PUBLIC "${TEST_DIRECTORY}" "${TEST_INCLUDE_DIRS}" PRIVATE "${TEST_DIRECTORY}")

    include(GoogleTest)
    gtest_discover_tests(${TEST_NAME})

EndFunction()