cmake_minimum_required(VERSION 3.14)

include(Base/CompileCommands)

include(Target/Application)
include(Install/Application)

out_of_source_check("In-source builds not allowed")
export_compile_commands()

project(cmake-template VERSION 0.1.0)
create_application(calculator)

add_executable_sources(calculator sources
  main.cc)
add_library_sources(calculator sources/calculator
  calculator.cc)
add_executable_resources(calculator resources
  resource.txt)

install_application(calculator)
add_subdirectory(tests)
