
include(PropertiesManager)
include(GenerateExportHeader)
include(DependencyCreator)

#
# Utils
#

function(_include_build_directory target directory)
  target_include_directories(${target} PUBLIC $<BUILD_INTERFACE:${directory}>)
endfunction()

#
# Executable
#

function(_add_executable target_exe)
  add_executable(${target_exe}-exe)
endfunction()

function(_setup_executable target_exe)
  set_export_name(${target_exe}-exe ${target_exe})
  set_output_name(${target_exe}-exe ${target_exe})
endfunction()

function(_include_executable_headers target_exe)
  _include_build_directory(${target_exe}-exe ${PROJECT_SOURCE_DIR}/headers)
endfunction()

function(create_executable target_exe)
  _add_executable             (${target_exe})
  _setup_executable           (${target_exe})
  _include_executable_headers (${target_exe})
endfunction()

#
# Library
#

function(_add_library target_lib)
  add_library(${target_lib}-lib)
  add_library(${target_lib}::${target_lib} ALIAS ${target_lib}-lib)
endfunction()

function(_setup_library target_lib)
  set_export_name (${target_lib}-lib ${target_lib})
  set_output_name (${target_lib}-lib ${target_lib})
  set_version     (${target_lib}-lib ${PROJECT_VERSION})
  set_soversion   (${target_lib}-lib ${PROJECT_VERSION_MAJOR})
endfunction()

function(_include_library_headers target_lib)
  _include_build_directory(${target_lib}-lib ${CMAKE_CURRENT_SOURCE_DIR}/headers)
endfunction()

function(_include_library_export target_lib)
  _include_build_directory(${target_lib}-lib ${CMAKE_CURRENT_BINARY_DIR}/export)
endfunction()

function(_generate_export_header target_lib)
  generate_export_header(${target_lib}-lib
    BASE_NAME        ${target_lib}
    EXPORT_FILE_NAME ${CMAKE_CURRENT_BINARY_DIR}/export/${target_lib}/export.h)
endfunction()

function(_add_export_header target_lib)
  set_cxx_visibility_preset     (${target_lib}-lib hidden)
  set_visibility_inlines_hidden (${target_lib}-lib on)
  _generate_export_header       (${target_lib})
  _include_library_export       (${target_lib})
endfunction()

function(create_library target_lib)
  _add_library             (${target_lib})
  _setup_library           (${target_lib})
  _add_export_header       (${target_lib})
  _include_library_headers (${target_lib})
endfunction()

#
# Application
#

function(create_application target)
  create_library         (${target})
  create_executable      (${target})
  add_project_dependency (${target}-exe TARGET ${target}-lib)
endfunction()

#
# GTest executable
#

function(_add_test target_test)
  add_executable(${target_test}-test)
endfunction()

function(_setup_test target_test)
  set_export_name(${target_test}-test ${target_test})
  set_output_name(${target_test}-test ${target_test})
endfunction()

function(_add_framework_dependency target_test)
  add_library_dependency_checked(${target_test}-test
    NAME   GTest
    TARGET GTest::gtest)
endfunction()

function(_enable_testing target_test)
  include(GoogleTest)
  enable_testing()
  gtest_discover_tests(${target_test}-test)
endfunction()

function(_run_test target_test)
  add_custom_command(
    TARGET ${target_test}-test
    POST_BUILD
    COMMAND $<TARGET_FILE:${target_test}-test>)
endfunction()

function(create_test target_test)
  _add_test                 (${target_test})
  _setup_test               (${target_test})
  _add_framework_dependency (${target_test})
  _enable_testing           (${target_test})
  _run_test                 (${target_test})
endfunction()

#
# Sources
#

function(_add_single_source target source_dir source_file)
  target_sources(${target} PRIVATE ${source_dir}/${source_file})
endfunction()

function(_add_multi_source target source_dir)
  foreach(source_file IN ITEMS ${ARGN})
    _add_single_source(${target} ${source_dir} ${source_file})
  endforeach()
endfunction()

function(add_executable_sources target_exe source_dir)
  _add_multi_source(${target_exe}-exe ${source_dir} ${ARGN})
endfunction()

function(add_library_sources target_lib source_dir)
  _add_multi_source(${target_lib}-lib ${source_dir} ${ARGN})
endfunction()

function(add_test_sources target_test source_dir)
  _add_multi_source(${target_test}-test ${source_dir} ${ARGN})
endfunction()
