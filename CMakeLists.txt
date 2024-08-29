cmake_minimum_required(VERSION 3.14)

include(InSourceError)
include(ExportCompileCommands)
include(TargetCreator)
include(TargetInstaller)

in_source_error("In-source builds not allowed")
export_compile_commands()

project(cmake-template VERSION 0.1.0)
create_application(calculator)

add_executable_sources(calculator sources
  main.cc)
add_library_sources(calculator sources/calculator
  calculator.cc)

install_application(calculator)
add_subdirectory(tests)
