# Create a module within the project, helps split up different functionalities into their own libs
Create_Module(
    NAME ${PROJECT_NAME}
    LANGUAGE CXX
    DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/src"
    DEPENDENCIES bt_core
    INCLUDE_DIRS "${bt_core_Include_Dir}"
)