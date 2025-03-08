cmake_minimum_required(VERSION 3.31.3)
project(test_url CXX)

# Enable C++20
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(Boost_USE_STATIC_LIBS ON)

# Conan setup

# include(${CMAKE_SOURCE_DIR}/build/conan/conan_toolchain.cmake)

# Find Boost.URL
find_package(Boost REQUIRED COMPONENTS url)

# Define executable
add_executable(test-url test_url.cpp)

target_compile_options(test-url PRIVATE
    $<$<CONFIG:Debug>:-g>    # Add -g for Debug builds
    $<$<CONFIG:Release>:-O2> # Add -O2 for Release builds
)

# Include Boost headers
target_include_directories(test-url PRIVATE ${Boost_INCLUDE_DIRS})

#target_link_libraries(test-url PRIVATE 
#    $<$<CONFIG:Debug>:Boost::urld>   # Debug build links Boost::urld (if available)
#    $<$<CONFIG:Release>:Boost::url>  # Release build links Boost::url
#)

## Link Boost.URL correctly
target_link_libraries(test-url PRIVATE Boost::url)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
install(TARGETS test-url RUNTIME DESTINATION bin)

# Enable warnings
if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    target_compile_options(test-url PRIVATE -Wall -Wextra -Wpedantic)
endif()
