cmake_minimum_required(VERSION 3.14)

include(TargetCreator)
include(DependencyCreator)

create_test(calculator)

add_project_dependency(calculator-test
  TARGET calculator::calculator)

add_test_sources(calculator sources
  main.cc)
add_test_sources(calculator sources/calculator
  calculator_test.cc)
