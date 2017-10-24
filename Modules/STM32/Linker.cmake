# TODO: Add support for external RAM

function ( stm32_generate_ldscript linker_script_template linker_script_path )
	configure_file ( ${linker_script_template} ${linker_script_path} @ONLY )
endfunction ()

function ( stm32_generate_default_ldscript linker_script_path )
	stm32_generate_ldscript ( ${STM32_CMAKE_PATH}/STM32/${STM32_SERIES}/ldscript.template ${linker_script_path} )
endfunction ()
