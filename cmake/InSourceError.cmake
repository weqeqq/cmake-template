
function(in_source_error message)
  if(CMAKE_BINARY_DIR STREQUAL CMAKE_SOURCE_DIR)
    message(FATAL_ERROR "${message}")
  endif()
endfunction()
