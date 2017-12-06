set ( STM32HAL_FOUND false )
if ( ${STM32Cube_FOUND} )
	stm32_find ( STM32HAL_INCLUDE "${STM32Cube}/Drivers/STM32${STM32_SERIES}xx_HAL_Driver/Inc/stm32${STM32_SERIES_LOWERCASE}xx_hal.h" DIRECTORY )
	if ( NOT STM32HAL_INCLUDE )
		message ( FATAL_ERROR "The ${STM32Cube}/Drivers/STM32${STM32_SERIES}xx_HAL_Driver/Inc/stm32${STM32_SERIES_LOWERCASE}xx_hal.h can not found, please try to fix ${STM32Cube} package." )
	endif ()

	if ( NOT EXISTS ${PROJECT_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal_conf.h )
		configure_file ( ${STM32HAL_INCLUDE}/stm32${STM32_SERIES_LOWERCASE}xx_hal_conf_template.h ${PROJECT_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal_conf.h COPYONLY )
		message ( STATUS "Copy ${STM32HAL_INCLUDE}/stm32${STM32_SERIES_LOWERCASE}xx_hal_conf_template.h to your project, you can custom." )
	endif ()

	stm32_find ( STM32HAL_SOURCE_DIR "${STM32Cube}/Drivers/STM32${STM32_SERIES}xx_HAL_Driver/Src/stm32${STM32_SERIES_LOWERCASE}xx_hal.c" DIRECTORY )
	if ( NOT STM32HAL_SOURCE_DIR )
		message ( FATAL_ERROR "The ${STM32Cube}/Drivers/STM32${STM32_SERIES}xx_HAL_Driver/Src can not found, please try to fix ${STM32Cube} package." )
	endif ()

	stm32_find ( STM32HAL_SOURCE_FILES "${STM32HAL_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal.c" )
	if ( NOT STM32HAL_SOURCE_FILES )
		message ( FATAL_ERROR "The stm32${STM32_SERIES_LOWERCASE}xx_hal.c can not found in ${STM32HAL_SOURCE_DIR}, please try to fix ${STM32Cube} package." )
	endif ()

	stm32_find ( STM32HAL_MSP_SOURCE_FILE "${STM32HAL_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal_msp_template.c" )
	if ( NOT STM32HAL_MSP_SOURCE_FILE )
		message ( FATAL_ERROR "The stm32${STM32_SERIES_LOWERCASE}xx_hal_msp_template.c can not found in ${STM32HAL_SOURCE_DIR}, please try to fix ${STM32Cube} package." )
	elseif ( NOT EXISTS ${PROJECT_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal_msp.c )
		configure_file ( ${STM32HAL_MSP_SOURCE_FILE} ${PROJECT_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal_msp.c COPYONLY )
		message ( STATUS "Copy ${STM32HAL_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal_msp_template.c to your project, you can custom." )
	endif ()
	set ( STM32HAL_SOURCE_FILES ${STM32HAL_SOURCE_FILES} ${PROJECT_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal_msp.c )

	foreach ( COMPONENT ${STM32HAL_FIND_COMPONENTS} )
		stm32_find ( STM32HAL_${COMPONENT}_SOURCE_FILE "${STM32HAL_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal_${COMPONENT}.c" )
		if ( NOT STM32HAL_${COMPONENT}_SOURCE_FILE )
			message ( FATAL_ERROR "The stm32${STM32_SERIES_LOWERCASE}xx_hal_${COMPONENT}.c can not found in ${STM32Cube}/Drivers/STM32${STM32_SERIES}xx_HAL_Driver/Src." )
		endif ()
		set ( STM32HAL_SOURCE_FILES ${STM32HAL_SOURCE_FILES} ${STM32HAL_${COMPONENT}_SOURCE_FILE} )
		if ( "${COMPONENT}" MATCHES "[a-z]+_ex" )
			string ( REPLACE "_ex" "" COMPONENT ${COMPONENT} )
			stm32_find ( STM32HAL_${COMPONENT}_SOURCE_FILE "${STM32HAL_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal_${COMPONENT}.c" )
			if ( STM32HAL_${COMPONENT}_SOURCE_FILE )
				set ( STM32HAL_SOURCE_FILES ${STM32HAL_SOURCE_FILES} ${STM32HAL_${COMPONENT}_SOURCE_FILE} )
			endif ()
		endif ()
	endforeach ()
	set ( STM32HAL_FOUND true )
else ()
	message ( FATAL_ERROR "STM32Cube package not found, please download and install STM32Cube." )
endif ()

include ( FindPackageHandleStandardArgs )
find_package_handle_standard_args ( "STM32HAL"
									DEFAULT_MSG
									STM32HAL_FOUND
									STM32HAL_INCLUDE
									STM32HAL_SOURCE_FILES
									)