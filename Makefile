.PHONY: debug release

CONAN = /opt/tools/conan/macos/12/2.13.0/bin/conan
CMAKE = /opt/local/bin/cmake

build/conan-debug/conan_toolchain.cmake:
	$(CONAN) install . --output-folder=build/conan-debug --build=missing --profile=default --settings build_type=Debug

build/conan/conan_toolchain.cmake:
	$(CONAN) install . --output-folder=build/conan --build=missing --profile=default

debug: build/conan-debug/conan_toolchain.cmake
	$(CMAKE) -B build/debug -S . -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=build/conan-debug/conan_toolchain.cmake
	$(CMAKE) --build build/debug

release: build/conan/conan_toolchain.cmake
	$(CMAKE) -B build/release -S . -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=build/conan/conan_toolchain.cmake
	$(CMAKE) --build build/release

clean:
	find ./build -name "*.o" -delete

cleanall:
	@rm -rf build/
