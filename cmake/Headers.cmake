
include(Base/Check)

function(add_headers_public target directory)
  target_include_directories(${target} PUBLIC ${directory})
endfunction()

function(add_headers_private target directory)
  target_include_directories(${target} PRIVATE ${directory})
endfunction()

function(add_install_headers target directory)
  absolute_path_check(${directory} "include_public_install_interface")
  add_headers_public(${target} $<INSTALL_INTERFACE:${directory}>)
endfunction()

function(add_build_headers target directory)
  absolute_path_check(${directory} "include_build_interface")
  add_headers_public(${target} $<BUILD_INTERFACE:${directory}>)
endfunction()
