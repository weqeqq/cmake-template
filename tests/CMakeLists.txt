cmake_minimum_required(VERSION 3.14)

include(Target/Test)

out_of_source_check("sdfsdf")

project(cmake-template-tests)
create_test(calculator)

add_link_dependency(calculator-test
  TARGET calculator::calculator)

add_test_sources(calculator sources
  main.cc)
add_test_sources(calculator sources/calculator
  calculator_test.cc)
