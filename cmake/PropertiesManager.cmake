
function(set_export_name target export_name)
  set_target_properties(${target} PROPERTIES EXPORT_NAME ${export_name})
endfunction()

function(set_output_name target output_name)
  set_target_properties(${target} PROPERTIES OUTPUT_NAME ${output_name})
endfunction()

function(set_cxx_visibility_preset target cxx_visibility_preset)
  set_target_properties(${target} PROPERTIES CXX_VISIBILITY_PRESET ${cxx_visibility_preset})
endfunction()

function(set_visibility_inlines_hidden target visibility_inlines_hidden)
  set_target_properties(${target} PROPERTIES VISIBILITY_INLINES_HIDDEN ${visibility_inlines_hidden})
endfunction()

function(set_version target version)
  set_target_properties(${target} PROPERTIES VERSION ${version})
endfunction()

function(set_soversion target soversion)
  set_target_properties(${target} PROPERTIES SOVERSION ${soversion})
endfunction()
