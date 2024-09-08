
include(Base/Message)

function(relative_path_check path message)
  cmake_path(IS_ABSOLUTE path result)
  if(result)
    fatal_error(${message})
  endif()
endfunction()

function(absolute_path_check path message)
  cmake_path(IS_RELATIVE path result)
  if(result)
    fatal_error(${message})
  endif()
endfunction()

function(out_of_source_check message)
  if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
    fatal_error(${message})
  endif()
endfunction()
