add_definitions ( -DSTM32F103xE ) #Add chip marco.

if ( NOT STM32_RAM_START_ADDRESS )
	set ( STM32_RAM_START_ADDRESS "0x20000000" )
endif ()

if ( NOT STM32_ROM_START_ADDRESS )
	set ( STM32_ROM_START_ADDRESS "0x08000000" )
endif ()

if ( NOT STM32_MIN_HEAP_SIZE )
	set ( STM32_MIN_HEAP_SIZE "0" )
endif ()

if ( NOT STM32_MIN_STACK_SIZE )
	set ( STM32_MIN_STACK_SIZE "0x400" )
endif ()

set ( STM32_RAM_SIZE 64K )
set ( STM32_ROM_SIZE 512K )
set ( STM32_RAM_END_ADDRESS "0x20010000" )

set ( STM32_STARTUP_SOURCE_NAME startup_stm32f103xe.s )