
include(Target/Executable)
include(Target/Library)

include(Dependency)
include(Resources)
include(Sources)
include(Headers)

function(create_application target)
  create_library         (${target})
  create_executable      (${target})
  add_link_dependency    (${target}-exe TARGET ${target}-lib)
endfunction()
