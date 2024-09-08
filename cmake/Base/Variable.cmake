
macro(set_parent_scope variable value)
  set(${variable} ${value} PARENT_SCOPE)
endmacro()

macro(push_to_parent_scope variable)
  set_parent_scope(${variable} ${${variable}})
endmacro()
