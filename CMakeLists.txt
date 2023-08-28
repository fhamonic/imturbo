cmake_minimum_required(VERSION 3.12)

project(
    ImTurbo
    VERSION 1.0
    DESCRIPTION "ImTurbo"
    LANGUAGES CXX)

# set(CMAKE_VERBOSE_MAKEFILE ON)

# ################### Options ####################
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(OPTIMIZE_FOR_NATIVE "" OFF)

# ################### Modules ####################
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})
include(GNUInstallDirs)
include(CompilerWarnings)
include(CompilerOptimizations)

# ################### Packages ####################
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup(TARGETS)

# ################### ImTurbo #####################
file(GLOB DEPEDENCIES_CPP dependencies/ImGuiFileDialog/*.cpp dependencies/imgui_toggle/*.cpp)
add_executable(imturbo src/main.cpp imgui_backends/imgui_impl_glfw.cpp imgui_backends/imgui_impl_opengl2.cpp ${DEPEDENCIES_CPP})
target_include_directories(imturbo PUBLIC include imgui_backends dependencies)
target_link_libraries(imturbo PUBLIC CONAN_PKG::glfw CONAN_PKG::glew CONAN_PKG::imgui CONAN_PKG::implot)
target_link_libraries(imturbo PUBLIC CONAN_PKG::boost)
set_project_warnings(imturbo)
set_project_optimizations(imturbo)

