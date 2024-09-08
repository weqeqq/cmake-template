
include(Base/Property)

include(Dependency)
include(Resources)
include(Sources)
include(Headers)

function(_add_test target_test)
  add_executable(${target_test}-test)
endfunction()

function(_setup_test target_test)
  set_export_name(${target_test}-test ${target_test})
  set_output_name(${target_test}-test ${target_test})
endfunction()

function(_add_framework_dependency target_test)
  add_local_library_dependency(${target_test}-test
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
