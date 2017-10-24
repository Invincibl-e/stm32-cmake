set ( STM32HAL_FOUND false )
if ( ${STM32Cube_FOUND} )
	string ( TOLOWER "${STM32_SERIES}" STM32_SERIES_LOWERCASE )
	stm32_find ( STM32HAL_INCLUDE "${STM32Cube}/Drivers/STM32${STM32_SERIES}xx_HAL_Driver/Inc/stm32${STM32_SERIES_LOWERCASE}xx_hal.h" DIRECTORY )
	if ( NOT EXISTS ${PROJECT_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal_conf.h )
		configure_file ( ${STM32HAL_INCLUDE}/stm32${STM32_SERIES_LOWERCASE}xx_hal_conf_template.h ${PROJECT_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal_conf.h COPYONLY )
		message ( STATUS "Copy ${STM32HAL_INCLUDE}/stm32${STM32_SERIES_LOWERCASE}xx_hal_conf_template.h to your project, you can custom." )
	endif ()

	stm32_find ( STM32HAL_SOURCE_DIR "${STM32Cube}/Drivers/STM32${STM32_SERIES}xx_HAL_Driver/Src" )
	if ( IS_DIRECTORY "${STM32HAL_SOURCE_DIR}" )
		stm32_find ( STM32HAL_SOURCE_FILES "${STM32HAL_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal.c" )
		if ( NOT STM32HAL_SOURCE_FILES )
			message ( FATAL_ERROR "The stm32${STM32_SERIES_LOWERCASE}xx_hal.c can not found in ${STM32HAL_SOURCE_DIR}." )
		endif ()
		foreach ( COMPONENT ${STM32HAL_FIND_COMPONENTS} )
			stm32_find ( STM32HAL_${COMPONENT}_SOURCE_FILE "${STM32HAL_SOURCE_DIR}/stm32${STM32_SERIES_LOWERCASE}xx_hal_${COMPONENT}.c" )
			if ( NOT STM32HAL_${COMPONENT}_SOURCE_FILE )
				message ( FATAL_ERROR "The stm32${STM32_SERIES_LOWERCASE}xx_hal_${COMPONENT}.c can not found in ${STM32Cube}/Drivers/STM32${STM32_SERIES}xx_HAL_Driver/Src." )
			endif ()
			set ( STM32HAL_SOURCE_FILES ${STM32HAL_SOURCE_FILES} ${STM32HAL_${COMPONENT}_SOURCE_FILE} )
		endforeach ()
		set ( STM32HAL_FOUND true )
	else ()
		message ( FATAL_ERROR "${STM32HAL_SOURCE_DIR} not found, please try to fix STM32Cube." )
	endif ()
else ()
	message ( FATAL_ERROR "STM32Cube not found, please download and install STM32Cube." )
endif ()

include ( FindPackageHandleStandardArgs )
find_package_handle_standard_args ( "STM32HAL"
									DEFAULT_MSG
									STM32HAL_FOUND
									STM32HAL_INCLUDE
									STM32HAL_SOURCE_FILES
									)