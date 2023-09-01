from conan import ConanFile
from conan.tools.cmake import CMake
from conan.tools.files import copy


class CompressorRecipe(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeToolchain", "CMakeDeps"
    build_policy = "missing"

    def requirements(self):
        self.imgui_version = "1.89.4"
        self.requires("imgui/" + self.imgui_version)
        self.requires("implot/0.14")
        self.requires("glfw/3.3.8")
        self.requires("glew/2.2.0")
        self.requires("boost/1.80.0")
        self.requires("poco/1.10.1")

    def build_requirements(self):
        self.tool_requires("cmake/3.27.1")

    def generate(self):
        bindings_path = (
            self.dependencies["imgui/" + self.imgui_version].package_folder
            + "/res/bindings"
        )
        copy(self, "*.cpp", bindings_path, self.source_folder + "/imgui_backends")
        copy(self, "*.h", bindings_path, self.source_folder + "/imgui_backends")
        fonts_path = (
            self.dependencies["imgui/" + self.imgui_version].package_folder
            + "/res/fonts"
        )
        copy(self, "Roboto-Medium.ttf", fonts_path, self.source_folder + "/fonts")

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()
