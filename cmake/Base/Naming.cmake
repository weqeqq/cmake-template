
include(Base/String)

function(remove_special variable value)
  string(REGEX REPLACE "[^_a-zA-Z0-9]+" "" ${variable} ${value})
  set(${variable} ${${variable}} PARENT_SCOPE)
endfunction()

function(to_camel_case variable value)
  string_regex_matchall("." ${value} ${variable})
  set(output)
  set(was_underscore)
  foreach(letter ${${variable}})
    string_compare_equal(${letter} "_" result)
    if(result)
      set(was_underscore true)
      continue()
    endif()
    if(was_underscore)
      string_toupper_modify(letter)
      set(was_underscore false)
    endif()
    string(APPEND output ${letter})
  endforeach()
  set(${variable} ${output} PARENT_SCOPE)
endfunction()

function(to_pascal_case variable value)
  to_camel_case(${variable} ${value})
  string_substring(${${variable}} 0 1  first_letter)
  string_substring(${${variable}} 1 -1 rest_of_string)
  string_toupper_modify(first_letter)
  string_concat(${variable} ${first_letter} ${rest_of_string})
  set(${variable} ${${variable}} PARENT_SCOPE)
endfunction()

function(to_snake_case variable value)
  string_replace("-" "_" ${variable} ${value})
  set(${variable} ${${variable}} PARENT_SCOPE)
endfunction()
