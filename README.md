# stm32 cmake
Use cmake to build your stm32 project!

## Requirements
* [GNU Arm Embedded Toolchain](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm)
* [STM32CubeMX](http://www.st.com/en/development-tools/stm32cubemx.html) ( You need to download the library for your chip )

## Usage
You need to do :
```shell
cmake -DSTM32_MODEL=<your chip model> -DCMAKE_TOOLCHAIN_FILE=<path_to_STM32.cmake> -DCMAKE_BUILD_TYPE=Debug <path_to_source_dir>
```
and add `${STM32_INCLUDE}` `${STM32_SOURCE_FILES}` to your CMakeLists.txt. Maybe your need to link with `${STM32_LIBRARY}`


* `STM32_MODEL` - Must. eg. STM32F411CE ( Only 12  ).
* `CMAKE_TOOLCHAIN_FILE` - Must. `${stm32-cmake_PATH}/Modules/STM32.cmake`.
* `TOOLCHAIN_PREFIX` - default: `arm-none-eabi`.
* `STM32Cube_DIR` - Set the STM32Cube repository directory. default: `~/STM32Cube/Repository/`.
* `STM32Cube_VERSION` - Set the STM32Cube firmware version. default: latest. eg. `${STM32Cube_DIR}/STM32Cube_FW_${STM32_SERIES}_V${STM32Cube_VERSION}`
* `STM32_SPECS` - Set the compile option: `--specs`. default: `nosys`.( [Documentation](https://launchpadlibrarian.net/287100883/readme.txt) )
* `STM32_CUSTOM_SYSCALL` - If `ON`, will generate a `syscalls.c` to your ${PROJECT_SOURCE_DIR}. default: `OFF`.( [Documentation](https://launchpadlibrarian.net/287100883/readme.txt) )
* `STM32_LINKER_SCRIPT` - You can custom the link script template. default: `${stm32-cmake_PATH}/Modules/STM32/${STM32_SERIES}/ldscript.template`.

## Add chip support
Now, Only supports five chip. but you can add a support for your chip.

Support List | Cmake Script
:----: | :----:
STM32F103C8  |[STM32F103C8.cmake](./Modules/STM32/F1/STM32F103C8.cmake)
STM32F103VC  |[STM32F103VC.cmake](./Modules/STM32/F1/STM32F103VC.cmake)
STM32F103ZE  |[STM32F103ZE.cmake](./Modules/STM32/F1/STM32F103ZE.cmake)
STM32F411CE  |[STM32F411CE.cmake](./Modules/STM32/F1/STM32F411CE.cmake)

```
├── Modules
│   ├── FindCMSIS.cmake
│   ├── FindSTM32Cube.cmake
│   ├── FindSTM32HAL.cmake
│   ├── STM32
│   │   ├── F1                     #F1 series.
│   │   │   ├── STM32F103C8.cmake  #Chip model ( One to one ).
│   │   │   ├── STM32F103VC.cmake  #Chip model ( One to one ).
│   │   │   ├── STM32F103ZE.cmake  #Chip model ( One to one ).
│   │   │   ├── cmake.cmake        #F1 cmake.
│   │   │   └── ldscript.template  #F1 link script template.
│   │   ├── F4                     #F4 series.
│   │   │   ├── STM32F411CE.cmake  #Chip model ( One to one ).
│   │   │   ├── cmake.cmake        #F4 cmake.
│   │   │   └── ldscript.template  #F4 link script template.
│   │   ├── Linker.cmake
│   │   ├── Util.cmake
│   │   └── syscalls.c
│   └── STM32.cmake                #Main cmake.
```

If you use the F1 or F4 series chip, you only need copy `STM32F103C8.cmake` or `STM32F411CE.cmake` and change some parameters.
* `add_definitions ( -DSTM32F411xE )` - Set chip marco.
* `STM32_RAM_START_ADDRESS` - Chip ram start address.
* `STM32_ROM_START_ADDRESS` - Chip rom start address.
* `STM32_RAM_SIZE` - Chip ram size.
* `STM32_ROM_SIZE` - Chip rom size.
* `STM32_RAM_END_ADDRESS` - Chip ram end address ( ram start address + ram size ).
* `STM32_STARTUP_SOURCE_NAME` - Chip startup source code name.

Finally, push it!!! Thanks!

If you don't use F1 or F4 series chip, you can copy Modules/F4/cmake.cmake and change some parameters too. But I think you can take a issues and tell me the parameters. Then I will do it.
