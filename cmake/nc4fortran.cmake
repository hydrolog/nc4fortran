include(ExternalProject)

if(NOT nc4fortran_external)
  find_package(nc4fortran CONFIG)

  if(nc4fortran_FOUND)
    message(STATUS: "nc4fortran found: ${nc4fortran_DIR}")
    return()
  endif()
endif()

set(nc4fortran_external true CACHE BOOL "Build nc4fortran")

find_package(NetCDF REQUIRED COMPONENTS Fortran)


set(nc4fortran_INCLUDE_DIRS ${CMAKE_INSTALL_PREFIX}/include)

if(BUILD_SHARED_LIBS)
  set(nc4fortran_LIBRARIES ${CMAKE_INSTALL_PREFIX}/lib/${CMAKE_SHARED_LIBRARY_PREFIX}nc4fortran${CMAKE_SHARED_LIBRARY_SUFFIX})
else()
  set(nc4fortran_LIBRARIES ${CMAKE_INSTALL_PREFIX}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}nc4fortran${CMAKE_STATIC_LIBRARY_SUFFIX})
endif()

set(nc4fortran_cmake_args
-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}
-DCMAKE_PREFIX_PATH:PATH=${CMAKE_INSTALL_PREFIX}
-DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
-DCMAKE_BUILD_TYPE=Release
-DBUILD_TESTING:BOOL=false
-Dautobuild:BOOL=false
-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
-DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER}
)

ExternalProject_Add(NC4FORTRAN
SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..
CMAKE_ARGS ${nc4fortran_cmake_args}
CMAKE_GENERATOR ${EXTPROJ_GENERATOR}
BUILD_BYPRODUCTS ${nc4fortran_LIBRARIES}
INACTIVITY_TIMEOUT 15
CONFIGURE_HANDLED_BY_BUILD ON
)

file(MAKE_DIRECTORY ${nc4fortran_INCLUDE_DIRS})

add_library(nc4fortran::nc4fortran INTERFACE IMPORTED GLOBAL)
target_link_libraries(nc4fortran::nc4fortran INTERFACE ${nc4fortran_LIBRARIES} NetCDF::NetCDF_Fortran)
target_include_directories(nc4fortran::nc4fortran INTERFACE ${nc4fortran_INCLUDE_DIRS})

# race condition for linking without this
add_dependencies(nc4fortran::nc4fortran NC4FORTRAN)
