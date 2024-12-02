message(STATUS "${PROJECT_NAME} ${PROJECT_VERSION} CMake ${CMAKE_VERSION} Toolchain ${CMAKE_TOOLCHAIN_FILE}")

option(nc4fortran_COVERAGE "Code coverage tests")
option(tidy "Run clang-tidy on the code")
option(find "find NetCDF libraries" ON)

option(nc4fortran_BUILD_TESTING "Build tests" ${nc4fortran_IS_TOP_LEVEL})

set_property(DIRECTORY PROPERTY EP_UPDATE_DISCONNECTED true)

# Necessary for shared library with Visual Studio / Windows oneAPI
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS true)
