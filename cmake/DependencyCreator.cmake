
function(add_project_dependency target)
  cmake_parse_arguments("" "" "TARGET" "" ${ARGN})
  target_include_directories (${target} PUBLIC  ${_TARGET})
  target_link_libraries      (${target} PRIVATE ${_TARGET})
endfunction()

function(add_library_dependency target)
  cmake_parse_arguments("" "" "TARGET;NAME" "" ${ARGN})
  find_package(${_NAME} QUIET)

  set(${_NAME}_FOUND ${${_NAME}_FOUND} PARENT_SCOPE)
  set(LIBRARY_FOUND  ${${_NAME}_FOUND} PARENT_SCOPE)

  if(${_NAME}_FOUND)
    add_project_dependency(${target} TARGET ${_TARGET})
  endif()
endfunction()

function(check_for_library_found message)
  if(NOT LIBRARY_FOUND)
    message(FATAL_ERROR ${message})
  endif()
endfunction()

function(add_library_dependency_checked target)
  cmake_parse_arguments("" "" "NAME" "" ${ARGN})
  add_library_dependency(${target} ${ARGN})
  check_for_library_found("Dependency ${_NAME} does not found.")
endfunction()

include(FetchContent)
function(add_git_library_dependency target)
  cmake_parse_arguments("" "" "TARGET;REPOSITORY;TAG;NAME" "" ${ARGN})
  FetchContent_Declare(
    ${_NAME}
    GIT_REPOSITORY https://github.com/${_REPOSITORY}
    GIT_TAG        ${_TAG})
  FetchContent_MakeAvailable(${_NAME})
  add_project_dependency(${target} TARGET ${_TARGET})
endfunction()
