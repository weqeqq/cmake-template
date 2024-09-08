
function(status message)
  message(STATUS ${message})
endfunction()

function(fatal_error message)
  message(FATAL_ERROR ${message})
endfunction()
