
include(Base/Variable)

function(string_replace match replace value variable)
  string(REPLACE ${match} ${replace} ${variable} ${value})
  push_to_parent_scope(${variable})
endfunction()

function(string_replace_modify match replace variable)
  string_replace(${match} ${replace} ${${variable}} ${variable})
  push_to_parent_scope(${variable})
endfunction()

function(string_toupper value variable)
  string(TOUPPER ${value} ${variable})
  push_to_parent_scope(${variable})
endfunction()

function(string_toupper_modify variable)
  string_toupper(${${variable}} ${variable})
  push_to_parent_scope(${variable})
endfunction()

function(string_regex_matchall expression value variable)
  string(REGEX MATCHALL ${expression} ${variable} ${value})
  set(${variable} ${${variable}} PARENT_SCOPE)
endfunction()

function(string_regex_matchall_modify expression variable)
  string_regex_matchall(${expression} ${${variable}} ${variable})
  set(${variable} ${${variable}} PARENT_SCOPE)
endfunction()

function(string_compare_equal lhs_value rhs_value variable)
  string(COMPARE EQUAL ${lhs_value} ${rhs_value} ${variable})
  set(${variable} ${${variable}} PARENT_SCOPE)
endfunction()

function(string_substring value begin length variable)
  string(SUBSTRING ${value} ${begin} ${length} ${variable})
  set(${variable} ${${variable}} PARENT_SCOPE)
endfunction()

function(string_concat variable)
  string(CONCAT ${variable} ${ARGN})
  set(${variable} ${${variable}} PARENT_SCOPE)
endfunction()
