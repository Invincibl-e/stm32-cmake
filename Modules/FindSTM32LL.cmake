set ( STM32LL_FOUND false )
if ( ${STM32Cube_FOUND} )
	stm32_find ( STM32LL_INCLUDE "${STM32Cube}/Drivers/STM32${STM32_SERIES}xx_HAL_Driver/Inc/stm32${STM32_SERIES_LOWERCASE}xx_ll_gpio.h" DIRECTORY )
	if ( NOT STM32LL_INCLUDE )
		message ( FATAL_ERROR "The ${STM32Cube}/Drivers/STM32${STM32_SERIES}xx_HAL_Driver/Inc/stm32${STM32_SERIES_LOWERCASE}xx_ll_gpio.h can not found in ${STM32Cube}/Drivers/STM32${STM32_SERIES}xx_HAL_Driver/Inc/, please try to fix ${STM32Cube} package." )
	endif ()

	stm32_find ( STM32LL_SOURCE_DIR "${STM32Cube}/Drivers/STM32${STM32_SERIES}xx_HAL_Driver/Src" )
	if ( IS_DIRECTORY "${STM32LL_SOURCE_DIR}" )
		stm32_find ( STM32LL_SOURCE_FILES "${STM32LL_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_ll_gpio.c" )
		if ( NOT STM32LL_SOURCE_FILES )
			message ( FATAL_ERROR "The stm32${STM32_SERIES_LOWERCASE}xx_ll_gpio.c can not found in ${STM32LL_SOURCE_DIR}, please try to fix ${STM32Cube} package." )
		endif ()
		foreach ( COMPONENT ${STM32LL_FIND_COMPONENTS} )
			stm32_find ( STM32LL_${COMPONENT}_SOURCE_FILE "${STM32LL_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_ll_${COMPONENT}.c" )
			if ( NOT STM32LL_${COMPONENT}_SOURCE_FILE )
				message ( FATAL_ERROR "The stm32${STM32_SERIES_LOWERCASE}xx_ll_${COMPONENT}.c can not found in ${STM32Cube}/Drivers/STM32${STM32_SERIES}xx_HAL_Driver/Src, please try to fix ${STM32Cube} package." )
			endif ()
			set ( STM32LL_SOURCE_FILES ${STM32LL_SOURCE_FILES} ${STM32LL_${COMPONENT}_SOURCE_FILE} )
		endforeach ()
		set ( STM32LL_FOUND true )
	else ()
		message ( FATAL_ERROR "${STM32LL_SOURCE_DIR} not found, please try to fix ${STM32Cube} package." )
	endif ()
else ()
	message ( FATAL_ERROR "STM32Cube package not found, please download and install STM32Cube." )
endif ()

include ( FindPackageHandleStandardArgs )
find_package_handle_standard_args ( "STM32LL"
									DEFAULT_MSG
									STM32LL_FOUND
									STM32LL_INCLUDE
									STM32LL_SOURCE_FILES
									)