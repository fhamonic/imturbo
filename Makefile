MAKEFLAGS += --no-print-directory

CPUS?=$(shell getconf _NPROCESSORS_ONLN || echo 1)

BUILD_DIR = build

.PHONY: all clean

all: $(BUILD_DIR)
	@cd $(BUILD_DIR) && \
	cmake --build . --config Release --parallel $(CPUS)

$(BUILD_DIR):
	mkdir imgui_backends
	mkdir fonts
	conan install . -of=$(BUILD_DIR) -b=missing
	cd $(BUILD_DIR) && \
	cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release

clean:
	@rm -rf $(BUILD_DIR)
	@rm -rf imgui_backends
	@rm -rf fonts