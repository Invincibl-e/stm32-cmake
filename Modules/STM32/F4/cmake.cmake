set ( CMAKE_SYSTEM_PROCESSOR cortex-m4 )

stm32_add_flags ( CMAKE_C_FLAGS
				  "-mthumb"
				  "-mcpu=cortex-m4"
				  "-mfpu=fpv4-sp-d16"
				  "-mfloat-abi=hard"
				  "-fmessage-length=0"
				  "-ffunction-sections"
				  "-fdata-sections"
				  )

stm32_add_flags ( CMAKE_CXX_FLAGS
				  "-mthumb"
				  "-mcpu=cortex-m4"
				  "-mfpu=fpv4-sp-d16"
				  "-mfloat-abi=hard"
				  "-fmessage-length=0"
				  "-ffunction-sections"
				  "-fdata-sections"
				  )

stm32_add_flags ( CMAKE_ASM_FLAGS
				  "-mthumb"
				  "-mcpu=cortex-m4"
				  "-mfpu=fpv4-sp-d16"
				  "-mfloat-abi=hard"
				  "-x"
				  "assembler-with-cpp"
				  )

stm32_add_flags ( CMAKE_EXE_LINKER_FLAGS
				  "-Wl,--gc-sections"
				  "-mthumb"
				  "-mcpu=cortex-m4"
				  "-mfloat-abi=hard"
				  "-T\"${PROJECT_SOURCE_DIR}/link_script.ld\""
				  )

add_definitions ( -DSTM32F4 )

if ( EXISTS ${STM32_CMAKE_PATH}/STM32/${STM32_SERIES}/${STM32_MODEL}.cmake )
	include ( STM32/${STM32_SERIES}/${STM32_MODEL} )
else ( EXISTS ${STM32_CMAKE_PATH}/STM32/${STM32_SERIES}/${STM32_MODEL}.cmake )
	message ( FATAL_ERROR "The ${STM32_MODEL} not support. You can write and send to me." )
endif ( EXISTS ${STM32_CMAKE_PATH}/STM32/${STM32_SERIES}/${STM32_MODEL}.cmake )

find_package ( STM32Cube )
find_package ( CMSIS )
if ( ${STM32Cube_FOUND} AND ${CMSIS_FOUND} )
	stm32_find ( STM32_INCLUDE "${STM32Cube}/Drivers/CMSIS/Device/ST/STM32${STM32_SERIES}xx/Include/stm32${STM32_SERIES_LOWERCASE}xx.h" DIRECTORY )
	set ( STM32_INCLUDE ${STM32_INCLUDE} ${CMSIS_INCLUDE} )
	if ( NOT EXISTS ${PROJECT_SOURCE_DIR}/startup.s )
		stm32_find ( STM32_STARTUP_SOURCE
					 "${STM32Cube}/Drivers/CMSIS/Device/ST/STM32${STM32_SERIES}xx/Source/Templates/gcc/${STM32_STARTUP_SOURCE_NAME}"
					 )
		configure_file ( ${STM32_STARTUP_SOURCE} ${PROJECT_SOURCE_DIR}/startup.s COPYONLY )
		message ( STATUS "Copy ${STM32_STARTUP_SOURCE} to your project, you can customize." )
	endif ()

	if ( NOT EXISTS ${PROJECT_SOURCE_DIR}/system_stm32${STM32_SERIES_LOWERCASE}xx.c )
		stm32_find ( STM32_SYSTEM_SOURCE
					 "${STM32Cube}/Drivers/CMSIS/Device/ST/STM32${STM32_SERIES}xx/Source/Templates/system_stm32${STM32_SERIES_LOWERCASE}xx.c"
					 )
		configure_file ( ${STM32_SYSTEM_SOURCE} ${PROJECT_SOURCE_DIR}/system_stm32${STM32_SERIES_LOWERCASE}xx.c COPYONLY )
		message ( STATUS "Copy ${STM32_SYSTEM_SOURCE} to your project, you can customize." )
	endif ()
	set ( STM32_SOURCE_FILES ${STM32_SOURCE_FILES} ${PROJECT_SOURCE_DIR}/startup.s ${PROJECT_SOURCE_DIR}/system_stm32${STM32_SERIES_LOWERCASE}xx.c )
	set ( STM32_LIBRARY ${CMSIS_LIBRARY} )
else ()
	message ( FATAL_ERROR "STM32Cube not found, please download and install STM32Cube." )
endif ()


include ( STM32/Linker )
if ( NOT EXISTS ${PROJECT_SOURCE_DIR}/link_script.ld )
	if ( STM32_LINKER_SCRIPT )
		stm32_generate_ldscript ( ${STM32_LINKER_SCRIPT} ${PROJECT_SOURCE_DIR} )
	else ()
		message ( STATUS "No STM32_LINKER_SCRIPT specified, generate default to ${PROJECT_SOURCE_DIR}/link_script.ld, maybe you want to edit." )
		stm32_generate_default_ldscript ( ${PROJECT_SOURCE_DIR}/link_script.ld )
	endif ()
endif ()

unset ( STM32_STARTUP_SOURCE_NAME )
