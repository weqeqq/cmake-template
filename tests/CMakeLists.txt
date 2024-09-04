cmake_minimum_required(VERSION 3.14)

include(TargetCreator)
include(DependencyCreator)

project(cmake-template-tests)
create_test_executable(calculator)

add_project_dependency(calculator-tests-exe
  TARGET calculator::calculator)

add_test_sources(calculator sources
  main.cc)
add_test_sources(calculator sources/calculator
  calculator_test.cc)
