Create_Test(
    NAME "${PROJECT_NAME}_test"
    DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/tests"
    DEPENDENCIES ${PROJECT_NAME} bt_core bt_types
    INCLUDE_DIRS "${bt_core_Include_Dir}" "${${PROJECT_NAME}_Include_Dir}"
)