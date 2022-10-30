# define type of the operating system 
set(CMAKE_SYSTEM_NAME Generic)
#processor type ARM
set(CMAKE_SYSTEM_PROCESSOR arm)

# set the arm toolchain prefix  
set(TOOLCHAIN_PREFIX arm-none-eabi-)
#C flags
set(FLAGS
    "-fdata-sections -ffunction-sections --specs=nano.specs -Wl,--gc-sections")
#CPP flags 
    set(CPP_FLAGS
    "-fno-rtti -fno-exceptions -fno-threadsafe-statics")

#set the toolchain utilities
set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc ${FLAGS})
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++ ${FLAGS} ${CPP_FLAGS})
set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}objcopy)
set(CMAKE_SIZE ${TOOLCHAIN_PREFIX}size)
set(CMAKE_OBJDUMP ${TOOLCHAIN_PREFIX}objdump)
#set the output generated file suffix
set(CMAKE_EXECUTABLE_SUFFIX_ASM ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX ".elf")
#static compile
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
