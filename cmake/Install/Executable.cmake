
function(install_executable target_exe)
  install(
    TARGETS           ${target_exe}-exe
    RUNTIME COMPONENT ${target_exe}-runtime)
endfunction()
