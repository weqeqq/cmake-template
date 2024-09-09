
function(path_remove_extension variable value)
  set(temp ${value})
  cmake_path(REMOVE_EXTENSION temp)
  set(${variable} ${temp} PARENT_SCOPE)
endfunction()
