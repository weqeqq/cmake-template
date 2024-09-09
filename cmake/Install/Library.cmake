
include(CMakePackageConfigHelpers)

function(_install_library_resources target_lib)
  if(EXISTS ${CMAKE_CURRENT_BINARY_DIR}/resources/headers)
    install(
      DIRECTORY  ${CMAKE_CURRENT_BINARY_DIR}/resources/headers
      DESTINATION include
      COMPONENT  ${target_lib}-development)
  endif()
endfunction()

function(_install_library_headers target_lib)
  _install_library_resources(${target_lib})
  install(
    DIRECTORY
      ${CMAKE_CURRENT_SOURCE_DIR}/headers/
      ${CMAKE_CURRENT_BINARY_DIR}/export/
    DESTINATION  include
    COMPONENT   ${target_lib}-development)
endfunction()

function(_install_library_target target_lib)
  install(
    TARGETS ${target_lib}-lib
    EXPORT  ${target_lib}-targets
    RUNTIME  COMPONENT ${target_lib}-runtime
    LIBRARY  COMPONENT ${target_lib}-runtime
    ARCHIVE  COMPONENT ${target_lib}-development
    NAMELINK_COMPONENT ${target_lib}-development)
endfunction()

function(_install_library_export target_lib)
  install(
    EXPORT      ${target_lib}-targets
    COMPONENT   ${target_lib}-development
    NAMESPACE   ${target_lib}::
    DESTINATION  lib/cmake/${target_lib})
endfunction()

# Config

function(_get_library_config_destination target_lib)
  set(library_config_destination lib/cmake/${target_lib} PARENT_SCOPE)
endfunction()

function(_configure_library_config target_lib)
  _get_library_config_destination(${target_lib})
  configure_package_config_file(
    ${PROJECT_SOURCE_DIR}/cmake/Install/Config.cmake
    ${target_lib}-config.cmake
    INSTALL_DESTINATION ${library_config_destination})
endfunction()

function(_install_library_config target_lib)
  _get_library_config_destination(${target_lib})
  install(
    FILES       ${CMAKE_CURRENT_BINARY_DIR}/${target_lib}-config.cmake
    COMPONENT   ${target_lib}-development
    DESTINATION ${library_config_destination})
endfunction()

function(_create_library_config target_lib)
  _configure_library_config(${target_lib})
  _install_library_config(${target_lib})
endfunction()

# Config version

function(_get_library_config_version_path target_lib)
  set(library_config_version_path ${CMAKE_CURRENT_BINARY_DIR}/${target_lib}-config-version.cmake PARENT_SCOPE)
endfunction()

function(_write_library_config_version target_lib)
  _get_library_config_version_path(${target_lib})
  write_basic_package_version_file(${library_config_version_path} COMPATIBILITY SameMajorVersion)
endfunction()

function(_install_library_config_version target_lib)
  _get_library_config_version_path(${target_lib})
  install(
    FILES       ${library_config_version_path}
    COMPONENT   ${target_lib}-development
    DESTINATION  lib/cmake/${target_lib})
endfunction()

function(_create_library_config_version target_lib)
  _write_library_config_version(${target_lib})
  _install_library_config_version(${target_lib})
endfunction()

# Install library

function(install_library target_lib)
  _install_library_headers       (${target_lib})
  _install_library_target        (${target_lib})
  _install_library_export        (${target_lib})
  _create_library_config         (${target_lib})
  _create_library_config_version (${target_lib})
endfunction()
