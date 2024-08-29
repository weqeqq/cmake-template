cmake_minimum_required(VERSION 3.14)

include(TargetCreator)
include(DependencyCreator)

project(cmake-template-tests)

create_gtest_executable(calculator-tests)

add_project_dependency(calculator-tests-exe
  TARGET calculator::calculator)

add_executable_sources(calculator-tests sources
  main.cc)
add_executable_sources(calculator-tests sources/calculator
  calculator_test.cc)
