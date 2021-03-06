set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(SANITIZER_BUILD "Build with AddressSanitizer" OFF)
set(SANITIZER "" CACHE STRING "Compile with -fsanitize=...")
option(ENABLE_BASHCC_TESTS "Build+execute bashcc's tests" OFF)
set(ASAN_LIB "libasan.so" CACHE STRING "Path to address sanitizer library")
set(RE2_BUILD_TESTING CACHE STRING OFF)

if (NOT "${SANITIZER}" STREQUAL "")
    add_compile_options(-fsanitize=${SANITIZER})
    add_link_options(-fsanitize=${SANITIZER})
    message(STATUS "Building with -fsanitize=${SANITIZER}")
    if (${SANITIZER} STREQUAL "memory")
        add_compile_options(-fsanitize-memory-track-origins=2 -fPIE -fPIC  -O2 -fsanitize-memory-use-after-dtor)
    else()
        add_compile_options(-O0)
    endif()
    if (${SANITIZER} STREQUAL "address")
        add_compile_options(-fsanitize=leak)
        add_link_options(-fsanitize=leak)
    endif()
    add_compile_options(-g -fno-omit-frame-pointer)
endif()
