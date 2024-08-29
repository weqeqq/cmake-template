
include(CMakePackageConfigHelpers)

#
# Install executable
#

function(install_executable target_exe)
  install(
    TARGETS           ${target_exe}-exe
    RUNTIME COMPONENT ${target_exe}-runtime)
endfunction()

#
# Install library
#

function(_install_library_headers target_lib)
  install(
    DIRECTORY
      ${PROJECT_SOURCE_DIR}/headers/
      ${PROJECT_BINARY_DIR}/export/
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
    ${PROJECT_SOURCE_DIR}/cmake/InstallConfig.cmake
    ${target_lib}-config.cmake
    INSTALL_DESTINATION ${library_config_destination})
endfunction()

function(_install_library_config target_lib)
  _get_library_config_destination(${target_lib})
  install(
    FILES       ${PROJECT_BINARY_DIR}/${target_lib}-config.cmake
    COMPONENT   ${target_lib}-development
    DESTINATION ${library_config_destination})
endfunction()

function(_create_library_config target_lib)
  _configure_library_config(${target_lib})
  _install_library_config(${target_lib})
endfunction()

# Config version

function(_get_library_config_version_path target_lib)
  set(library_config_version_path ${PROJECT_BINARY_DIR}/${target_lib}-config-version.cmake PARENT_SCOPE)
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

#
# Install application
#

function(install_application target_app)
  install_executable (${target_app})
  install_library    (${target_app})
endfunction()
