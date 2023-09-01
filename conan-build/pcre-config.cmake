########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(pcre_FIND_QUIETLY)
    set(pcre_MESSAGE_MODE VERBOSE)
else()
    set(pcre_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/pcreTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${pcre_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(pcre_VERSION_STRING "8.45")
set(pcre_INCLUDE_DIRS ${pcre_INCLUDE_DIRS_RELEASE} )
set(pcre_INCLUDE_DIR ${pcre_INCLUDE_DIRS_RELEASE} )
set(pcre_LIBRARIES ${pcre_LIBRARIES_RELEASE} )
set(pcre_DEFINITIONS ${pcre_DEFINITIONS_RELEASE} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${pcre_BUILD_MODULES_PATHS_RELEASE} )
    message(${pcre_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


