
function(_add_single_source target source_dir source_file)
  target_sources(${target} PRIVATE ${source_dir}/${source_file})
endfunction()

function(_add_multi_source target source_dir)
  foreach(source_file ${ARGN})
    _add_single_source(${target} ${source_dir} ${source_file})
  endforeach()
endfunction()

function(add_executable_sources target_exe source_dir)
  _add_multi_source(${target_exe}-exe ${source_dir} ${ARGN})
endfunction()

function(add_library_sources target_lib source_dir)
  _add_multi_source(${target_lib}-lib ${source_dir} ${ARGN})
endfunction()

function(add_test_sources target_test source_dir)
  _add_multi_source(${target_test}-test ${source_dir} ${ARGN})
endfunction()
