cmake_minimum_required(VERSION 3.0)
enable_language(C CXX)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(bashcc VERSION "1.3")

include(cmake/options.cmake)

# Add our compiler-compiler
add_subdirectory(neoast)

BuildParser(bash grammar/bash.y)
add_library(bash SHARED
        grammar/grammar.cc
        grammar/grammar.h
        ${bash_OUTPUT}
        )
target_include_directories(bash PRIVATE ${CMAKE_CURRENT_LIST_DIR}/include)
target_link_libraries(bash neoast)
