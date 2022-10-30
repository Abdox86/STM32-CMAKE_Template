# STM32-CMAKE_TEMPLATE
## _CMAKE Tamplate For STM32 Bare-Metal Programming_


Creating STM32 Bare-Metal project could be overwhalming, specially in situation when a solution needed to be belt from scratch, writing Makefile or CMAKE files is programming overhead, to avoid such thing this repo provides simple & effective solution to be used out of the bag. 
- It's free of any libraries or any firmware like (HAL or CMSIS)
- Portable to any STM32 device.
- Easy to implement drivers, wither own developed or ready-to-use like (HAL or CMSIS)



## _Project Structure_
This structue is just my concept of creating projects, however you can create any structure you would like, but if this structure works then here's the structure directories.
- ```app``` is the user top level application directory, contains ```inc``` for include files, ```src``` for source files.
- ```core``` drivers and linker script directory, in addition in case of using CMSIS or HAL, core is the best place to those files.
- ```boot``` boot or startup code directory for the STM32, each STM32 has it's dedicated startup file, search for the file using the device model number, i.e. ```STM32F411xE``` --> ```startup_stm32f411xe.s```. **Note:** the file in the boot is a place holder change it to your fit.
- ```CMakeLists.txt``` build file, please don't change anything in this file unless you know what you do.
- ```Makefile``` cmake build automation.
- ```arm-none-eabi.cmake``` toolchain setup to be used by cmake.
- ```setup.cmake``` user configuraton setup to use cmake. **More on this file in Usage** .

## _Dependencies_
- Make sure arm gnu toolchain is installed, run ``` arm-none-eabi-gcc --version``` in terminal, output should be the gcc version.
- Make sure Make & CMAKE is installed & update to date, run ```make -v```, and ```cmake -v```.

If all the above tools are installed and working proberly then you can proceed to the Usage

## _Usage_

-  ### **Poll the Repo**
    ```git clone https://github.com/Abdox86/STM32-CMAKE_Template.git```
- ### **setup.cmake**
    - Open the file ```setup.cmake```.
    - First two lines is to setup the project name & directory. 
        ``` cmake
        set(PROJECT_NAME <project-name>) #example sample-f411
        set(PROJECT_DIR <project-directory>) #example ${CMAKE_CURRENT_SOURCE_DIR}/app
        ```
    - Afterwards MCU family, model, specs.
        ```cmake
            set(MCU_FAMILY <mcu-family>) # example STM32F4
            set(MCU_MODEL <mcu-model>) # example STM32F411xE
            set(CPU_PARAMETERS <mcu-specs>) 
        ```
        the specs depend on the CPU, usually they are:
        - CPU architechture options, ```-mcpu=``` i.e  ```-mcpu=cortex-m4 ```, for the CPU ARM Cortex-M4.
        - ARM thumb instruction set, ```-mthumb```
        - Floating point type, 
            - ```-mfloat=hard``` for hardware based. 
            - ```-mfloat=soft``` for software based. 
        - Floating point arithmetic archithecture options, ```-mfpu```, i.e ```-mfpu=fpv4-sp-d16```, fpu version 4, single precision.
        - STM32 startup file, and linker script.
        ```cmake
        #boot file
        set(STARTUP_SCRIPT <file>) # example ${CMAKE_CURRENT_SOURCE_DIR}/boot/startup_stm32f411xe.s
        #linker file
        set(LINKER_SCRIPT <file>) # ${CMAKE_CURRENT_SOURCE_DIR}/core/linker/STM32F411CEUx_FLASH.ld
        ```
        - Include files directories.
        ```cmake
        #include files directory for the project 
        set(PROJECT_INC_DIR <include-directory>) # example ${CMAKE_CURRENT_SOURCE_DIR}/app/inc
        
        #include files directory for your firmware (i.e. STM32CUBEMX) 
        set(SYSTEM_INC_DIR <include-directory>) # example ${CMAKE_CURRENT_SOURCE_DIR}/core/drivers/inc 
        ```
        - Source files.
        ```cmake
        #project source files 
        set(PROJECT_SRC_FILES <source-files>) # example ${CMAKE_CURRENT_SOURCE_DIR}/app/*.c

        #firmware (if used) source files
        set(SYSTEM_SRC_FILES <source-file>) # example ${CMAKE_CURRENT_SOURCE_DIR}/core/drivers/src/*.c
        ```
- ### **Build**
    After configering the setup.cmake file you can try to build by
    - Run ```make``` in the same directory where CMakeLists.txt.
    the project should be built successfully if not please make sure you made all the previouse steps.
    - To clean the build, Run ```make clean```
    - To flash to your board, Run ```make stflash```, **NOTE:** see the Additional details for customizing the flash setup.
    - You should be up and running by now!!!, if you are NOT then have nice debugging session.

- ### **Additional details** 
    - The startup file ```startup_stm32f411xe.s``` is a place holder it can be used if you are using stm32f411xe controller, otherwise change it with your own.
    - The ```make stflash ``` command could be costumized to your fit, 
        -  open the ```Makefile```, 
        -  scroll to ```stflash:``` , you can see the command 
        ``` Makefile
        stflash:
            -st-flash --reset --format ihex write./${BUILD_DIR}/${PROJECT_NAME}.hex
        ```
         change the command up to your need.

### Cretids
#### Matej Blagšič [GitHub](https://github.com/prtzl/stm32-cmake) --> STM32-CMAKE


