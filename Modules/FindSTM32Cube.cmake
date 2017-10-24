set ( STM32Cube_FOUND false )
if ( NOT STM32Cube_DIR )
	set ( STM32Cube_DIR "~/STM32Cube/Repository/" )
endif ()
file ( TO_CMAKE_PATH "${STM32Cube_DIR}" STM32Cube_DIR )
if ( IS_DIRECTORY "${STM32Cube_DIR}" )
	if ( NOT PACKAGE_FIND_VERSION )
		message ( STATUS "No STM32Cube version specified, using the latest version." )
		file ( GLOB STM32Cube "${STM32Cube_DIR}/STM32Cube_FW_${STM32_SERIES}_V*" )
		list ( SORT STM32Cube )
		list ( REVERSE STM32Cube )
		list ( GET STM32Cube 0 STM32Cube )
	else ()
		set ( STM32Cube "${STM32Cube_DIR}/STM32Cube_FW_${STM32_SERIES}_V${PACKAGE_FIND_VERSION}" )
	endif ()
	if ( IS_DIRECTORY "${STM32Cube}" )
		message ( STATUS "Select STM32Cube in ${STM32Cube}" )
		set ( STM32Cube_FOUND true )
		string ( REPLACE "${STM32Cube_DIR}/STM32Cube_FW_${STM32_SERIES}_V" "" STM32Cube_VERSION ${STM32Cube} )
	else ()
		message ( FATAL_ERROR "The path ${STM32Cube} is invaid." )
	endif ()

else ()
	message ( FATAL_ERROR "Unknown STM32Cube path, please use -DSTM32Cube to set." )
endif ()

include ( FindPackageHandleStandardArgs )
find_package_handle_standard_args ( "STM32Cube"
									DEFAULT_MSG
									STM32Cube_FOUND
									STM32Cube
									)