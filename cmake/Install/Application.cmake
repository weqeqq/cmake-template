
include(Install/Executable)
include(Install/Library)

function(install_application target_app)
  install_executable (${target_app})
  install_library    (${target_app})
endfunction()
