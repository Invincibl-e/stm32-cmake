cmake_minimum_required ( VERSION 3.9 )
project ( stm32_test )


find_package ( STM32HAL COMPONENTS gpio REQUIRED )

set ( CMAKE_INCLUDE_CURRENT_DIR ON )
include_directories (
		${STM32_INCLUDE}
		${STM32HAL_INCLUDE}
)

set ( CMAKE_CXX_STANDARD 17 )
set ( SOURCE_FILES main.cpp )
add_executable ( stm32_test ${SOURCE_FILES} ${STM32_SOURCE_FILES} ${STM32HAL_SOURCE_FILES} )

stm32_add_bin_target ( stm32_test )
