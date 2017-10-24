set ( CMSIS_FOUND false )
if ( STM32 )
	if ( ${STM32Cube_FOUND} )
		stm32_find ( CMSIS_INCLUDE ${STM32Cube}/Drivers/CMSIS/Include/cmsis_gcc.h DIRECTORY )
		if ( IS_DIRECTORY "${STM32Cube}/Drivers/CMSIS/Lib/GCC" )
			file ( GLOB CMSIS_LIBRARY
				   LIST_DIRECTORIES false
				   "${STM32Cube}/Drivers/CMSIS/Lib/GCC/*.a"
				   )
			set ( CMSIS_FOUND true )
		else ()
			message ( FATAL_ERROR "${STM32Cube}/Drivers/CMSIS/Lib/GCC not found, please try to fix STM32Cube." )
		endif ()
	else ()
		message ( FATAL_ERROR "STM32Cube not found, please download and install STM32Cube." )
	endif ()
endif ()

include ( FindPackageHandleStandardArgs )
find_package_handle_standard_args ( "CMSIS"
									DEFAULT_MSG
									CMSIS_FOUND
									CMSIS_INCLUDE
									CMSIS_LIBRARY
									)