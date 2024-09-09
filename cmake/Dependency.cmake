
include(FetchContent)

function(add_link_dependency target)
  cmake_parse_arguments("" "" "TARGET" "" ${ARGN})
  target_link_libraries      (${target} PRIVATE ${_TARGET})
endfunction()

function(add_local_library_dependency target)
  cmake_parse_arguments("" "" "TARGET;NAME" "" ${ARGN})
  find_package(${_NAME} REQUIRED)
  add_link_dependency(${target} TARGET ${_TARGET})
endfunction()

function(add_git_library_dependency target)
  cmake_parse_arguments("" "" "TARGET;REPOSITORY;TAG;NAME" "" ${ARGN})
  FetchContent_Declare(
    ${_NAME}
    GIT_REPOSITORY https://github.com/${_REPOSITORY}
    GIT_TAG        ${_TAG})
  FetchContent_MakeAvailable(${_NAME})
  add_link_dependency(${target} TARGET ${_TARGET})
endfunction()
