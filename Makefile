MAKEFLAGS += --no-print-directory

CPUS?=$(shell getconf _NPROCESSORS_ONLN || echo 1)

BUILD_DIR = build

.PHONY: all clean

all: $(BUILD_DIR)
	@cd $(BUILD_DIR) && \
	cmake --build . --parallel $(CPUS)

$(BUILD_DIR):
	@mkdir $(BUILD_DIR) && \
	mkdir imgui_backends && \
	mkdir fonts && \
	cd $(BUILD_DIR) && \
	conan install .. --build=missing && \
	cmake -DCMAKE_BUILD_TYPE=Release -DOPTIMIZE_FOR_NATIVE=ON  ..

clean:
	@rm -rf $(BUILD_DIR)
	@rm -rf imgui_backends
	@rm -rf fonts