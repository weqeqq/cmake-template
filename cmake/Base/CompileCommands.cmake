
function(export_compile_commands)
  if(CMAKE_EXPORT_COMPILE_COMMANDS)
    execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink
      ${CMAKE_COMPILE_COMMANDS_INPUT_PATH}
      ${CMAKE_COMPILE_COMMANDS_OUTPUT_PATH})
  endif()
endfunction()
