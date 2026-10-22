Create_Example(
    NAME "${PROJECT_NAME}_example"
    DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/examples"
    DEPENDENCIES ${PROJECT_NAME} bt_core bt_types
    INCLUDE_DIRS "${bt_core_Include_Dir}" "${${PROJECT_NAME}_Include_Dir}"
)