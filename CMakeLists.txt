# cmake version requirements
cmake_minimum_required(VERSION 3.12.0)
#include toolchain file
include(gcc-arm-none-eabi.cmake)
#include setup file
include(setup.cmake)

#set options for genarating assemblu file
option(DUMP_ASM ON)


file(GLOB_RECURSE PROJECT_SRC_FILES CONFIGURE_DEPENDS
        ${SYSTEM_SRC_FILES}
        ${PROJECT_SRC_FILES})

project(${PROJECT_NAME})
set(EXECUTABLE ${CMAKE_PROJECT_NAME})

enable_language(C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

add_executable(
                ${EXECUTABLE}
                ${PROJECT_SRC_FILES}
                ${STARTUP_SCRIPT}
                )


target_include_directories(
                            ${EXECUTABLE} PRIVATE 
                            ${PROJECT_INC_DIR}
                            ${SYSTEM_INC_DIR}
                            )

target_compile_options(${EXECUTABLE} PRIVATE

    ${CPU_PARAMETERS}
    -Wall
    -Wextra
    -Wpedantic
    -Wshadow
    -Wdouble-promotion
    -Wformat=2 -Wformat-truncation
    -Wundef
    -fno-common
    -Wno-unused-parameter
    $<$<COMPILE_LANGUAGE:CXX>:
        -Wconversion # STM libraries!
        -Wno-volatile
        -Wold-style-cast
        -Wuseless-cast
        -Wsuggest-override>
    $<$<CONFIG:Debug>:-Og -g3 -ggdb>
    $<$<CONFIG:Release>:-Og -g0>)

target_link_options(${EXECUTABLE} PRIVATE
        -T${LINKER_SCRIPT}
        ${CPU_PARAMETERS}
       -Wl,-Map=${CMAKE_PROJECT_NAME}.map
       --specs=nosys.specs
        -Wl,--start-group
        -lc
        -lm
        -lstdc++
        -Wl,--end-group
        -Wl,--print-memory-usage)

# The last command can take a couple of seconds on larger project, usefull for debugging
add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${EXECUTABLE}>
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${EXECUTABLE}> ${EXECUTABLE}.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${EXECUTABLE}> ${EXECUTABLE}.bin)

if (${DUMP_ASM})
    add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
        COMMAND ${CMAKE_OBJDUMP} -D $<TARGET_FILE:${EXECUTABLE}> > ${EXECUTABLE}.s)
endif()
