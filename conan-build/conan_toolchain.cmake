

# Conan automatically generated toolchain file
# DO NOT EDIT MANUALLY, it will be overwritten

# Avoid including toolchain file several times (bad if appending to variables like
#   CMAKE_CXX_FLAGS. See https://github.com/android/ndk/issues/323
include_guard()

message(STATUS "Using Conan toolchain: ${CMAKE_CURRENT_LIST_FILE}")

if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeToolchain' generator only works with CMake >= 3.15")
endif()










string(APPEND CONAN_CXX_FLAGS " -m64")
string(APPEND CONAN_C_FLAGS " -m64")
string(APPEND CONAN_SHARED_LINKER_FLAGS " -m64")
string(APPEND CONAN_EXE_LINKER_FLAGS " -m64")



message(STATUS "Conan toolchain: C++ Standard 20 with extensions ON")
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Extra c, cxx, linkflags and defines


if(DEFINED CONAN_CXX_FLAGS)
  string(APPEND CMAKE_CXX_FLAGS_INIT " ${CONAN_CXX_FLAGS}")
endif()
if(DEFINED CONAN_C_FLAGS)
  string(APPEND CMAKE_C_FLAGS_INIT " ${CONAN_C_FLAGS}")
endif()
if(DEFINED CONAN_SHARED_LINKER_FLAGS)
  string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT " ${CONAN_SHARED_LINKER_FLAGS}")
endif()
if(DEFINED CONAN_EXE_LINKER_FLAGS)
  string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " ${CONAN_EXE_LINKER_FLAGS}")
endif()

get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if(_CMAKE_IN_TRY_COMPILE)
    message(STATUS "Running toolchain IN_TRY_COMPILE")
    return()
endif()

set(CMAKE_FIND_PACKAGE_PREFER_CONFIG ON)

# Definition of CMAKE_MODULE_PATH
# the generators folder (where conan generates files, like this toolchain)
list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

# Definition of CMAKE_PREFIX_PATH, CMAKE_XXXXX_PATH
# The Conan local "generators" folder, where this toolchain is saved.
list(PREPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_LIST_DIR} )
list(PREPEND CMAKE_PROGRAM_PATH "/home/plaiseek/.conan2/p/cmake8e5340c297c76/p/bin")
list(PREPEND CMAKE_LIBRARY_PATH "/home/plaiseek/.conan2/p/b/implo52a1d89c00e1f/p/lib" "/home/plaiseek/.conan2/p/b/imgui740464f07259c/p/lib" "/home/plaiseek/.conan2/p/b/glfwecc117442ab23/p/lib" "/home/plaiseek/.conan2/p/b/glew6b347eaab6c8d/p/lib" "/home/plaiseek/.conan2/p/b/boost070ce142ba15c/p/lib" "/home/plaiseek/.conan2/p/b/libba581978652a5b9/p/lib" "/home/plaiseek/.conan2/p/b/poco9d37499af2ff1/p/lib" "/home/plaiseek/.conan2/p/b/pcre328fc57712592/p/lib" "/home/plaiseek/.conan2/p/b/bzip2f7cc7c6cf796b/p/lib" "/home/plaiseek/.conan2/p/b/expatd98226ee7cfcb/p/lib" "/home/plaiseek/.conan2/p/b/sqlitd8fe9870c7e23/p/lib" "/home/plaiseek/.conan2/p/b/libpq364a77d9df112/p/lib" "/home/plaiseek/.conan2/p/b/libmy6eb0591a83c8c/p/lib" "/home/plaiseek/.conan2/p/b/opens7916b062e81c9/p/lib" "/home/plaiseek/.conan2/p/b/zlibba738c8d33d94/p/lib" "/home/plaiseek/.conan2/p/b/zstd84d7e735494ee/p/lib" "/home/plaiseek/.conan2/p/b/lz42588cd5fd1736/p/lib")
list(PREPEND CMAKE_INCLUDE_PATH "/home/plaiseek/.conan2/p/b/implo52a1d89c00e1f/p/include" "/home/plaiseek/.conan2/p/b/imgui740464f07259c/p/include" "/home/plaiseek/.conan2/p/b/glfwecc117442ab23/p/include" "/usr/include/uuid" "/home/plaiseek/.conan2/p/b/glew6b347eaab6c8d/p/include" "/home/plaiseek/.conan2/p/b/boost070ce142ba15c/p/include" "/home/plaiseek/.conan2/p/b/libba581978652a5b9/p/include" "/home/plaiseek/.conan2/p/b/poco9d37499af2ff1/p/include" "/home/plaiseek/.conan2/p/b/pcre328fc57712592/p/include" "/home/plaiseek/.conan2/p/b/bzip2f7cc7c6cf796b/p/include" "/home/plaiseek/.conan2/p/b/expatd98226ee7cfcb/p/include" "/home/plaiseek/.conan2/p/b/sqlitd8fe9870c7e23/p/include" "/home/plaiseek/.conan2/p/b/libpq364a77d9df112/p/include" "/home/plaiseek/.conan2/p/b/libmy6eb0591a83c8c/p/include" "/home/plaiseek/.conan2/p/b/opens7916b062e81c9/p/include" "/home/plaiseek/.conan2/p/b/zlibba738c8d33d94/p/include" "/home/plaiseek/.conan2/p/b/zstd84d7e735494ee/p/include" "/home/plaiseek/.conan2/p/b/lz42588cd5fd1736/p/include")



if (DEFINED ENV{PKG_CONFIG_PATH})
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:$ENV{PKG_CONFIG_PATH}")
else()
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:")
endif()




# Variables
# Variables  per configuration


# Preprocessor definitions
# Preprocessor definitions per configuration
