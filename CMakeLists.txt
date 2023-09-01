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

# ################### Packages ###################
find_package(imgui REQUIRED)
find_package(implot REQUIRED)
find_package(glfw3 REQUIRED)
find_package(GLEW REQUIRED)
find_package(Boost REQUIRED)
find_package(Poco REQUIRED)

# ################### ImTurbo #####################
file(GLOB DEPEDENCIES_CPP dependencies/ImGuiFileDialog/*.cpp dependencies/imgui_toggle/*.cpp)
add_executable(imturbo src/main.cpp imgui_backends/imgui_impl_glfw.cpp imgui_backends/imgui_impl_opengl2.cpp ${DEPEDENCIES_CPP})
target_include_directories(imturbo PUBLIC include imgui_backends dependencies)
target_link_libraries(imturbo PUBLIC glfw GLEW::GLEW imgui::imgui implot::implot)
target_link_libraries(imturbo PUBLIC Boost::boost Poco::Poco)
set_project_warnings(imturbo)
set_project_optimizations(imturbo)

target_compile_definitions(imturbo PUBLIC IMGUI_DEFINE_MATH_OPERATORS)

