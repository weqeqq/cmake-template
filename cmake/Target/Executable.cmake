
include(Base/Property)

include(Dependency)
include(Resources)
include(Sources)
include(Headers)

function(_add_executable target_exe)
  add_executable(${target_exe}-exe)
endfunction()

function(_setup_executable target_exe)
  set_export_name(${target_exe}-exe ${target_exe})
  set_output_name(${target_exe}-exe ${target_exe})
endfunction()

function(_add_executable_headers target_exe)
  add_build_headers(${target_exe}-exe ${CMAKE_CURRENT_SOURCE_DIR}/headers)
endfunction()

function(create_executable target_exe)
  _add_executable             (${target_exe})
  _setup_executable           (${target_exe})
  _add_executable_headers     (${target_exe})
endfunction()
