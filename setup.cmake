#set project configutations
#name 
set(PROJECT_NAME sample-f411)
#project source path 
set(PROJECT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/app)

#set mcu info
set(MCU_FAMILY STM32F4)
set(MCU_MODEL STM32F411xE)
set(CPU_PARAMETERS
    -mcpu=cortex-m4
    -mthumb
    -mfpu=fpv4-sp-d16
    -mfloat-abi=hard)

#boot file
set(STARTUP_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/boot/startup_stm32f411xe.s)
#linker file
set(LINKER_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/core/linker/STM32F411CEUx_FLASH.ld)

#include files directory for the project 
set(PROJECT_INC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/app/inc)

#include files directory for your firmware (i.e. STM32CUBEMX) 
set(SYSTEM_INC_DIR
    ${CMAKE_CURRENT_SOURCE_DIR}/core/drivers/inc) 

#project source files 
set(PROJECT_SRC_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/app/*.c)

#firmware (if used) source files
set(SYSTEM_SRC_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/core/drivers/src/*.c)