
include(Base/Variable)
include(Base/Message)
include(Base/String)
include(Base/Naming)

function(_get_resource_binary_dir)
  set(resource_binary_dir ${CMAKE_CURRENT_BINARY_DIR}/resources PARENT_SCOPE)
endfunction()

function(_get_resource_path resource_dir resource_file)
  set_parent_scope(resource_path ${resource_dir}/${resource_file})
endfunction()

function(_get_resource_input_path resource_dir resource_file)
  _get_resource_path(${resource_dir} ${resource_file})
  set_parent_scope(resource_input_path ${CMAKE_CURRENT_SOURCE_DIR}/${resource_path})
endfunction()

function(_get_resource_output_path resource_dir resource_file)
  _get_resource_binary_dir ()
  _get_resource_path       (${resource_dir} ${resource_file})
  set_parent_scope(resource_output_path ${resource_binary_dir}/${resource_path})
endfunction()

function(_get_resource_class_name resource_dir resource_file)
  _get_resource_path(${resource_dir} ${resource_file})
  set(resource_class_name ${resource_path})
  string_replace("/" "_" ${resource_class_name} resource_class_name)
  string_replace("." "_" ${resource_class_name} resource_class_name)
  to_pascal_case(         resource_class_name  ${resource_class_name})
  set(resource_class_name ${resource_class_name} PARENT_SCOPE)
endfunction()

function(_get_resource_header_dir)
  _get_resource_binary_dir()
  set(resource_header_dir ${resource_binary_dir}/headers/ PARENT_SCOPE)
endfunction()

function(_get_resource_source_dir)
  _get_resource_binary_dir()
  set(resource_source_dir ${resource_binary_dir}/sources/ PARENT_SCOPE)
endfunction()

function(_get_resource_header_path resource_dir resource_file)
  _get_resource_header_dir()
  set(header_file ${resource_file})
  string_replace ("/" "_" ${header_file} header_file)
  string_replace ("." "_" ${header_file} header_file)
  to_snake_case  (          header_file ${header_file})
  set(resource_header_path ${resource_header_dir}/${resource_dir}/${header_file}.h PARENT_SCOPE)
endfunction()

function(_create_resource_header resource_dir resource_file)
  _get_resource_class_name    (${resource_dir} ${resource_file})
  _get_resource_header_path   (${resource_dir} ${resource_file})

  file(WRITE ${resource_header_path} "
#include <cstdint>
#include <string_view>

class ${resource_class_name} {
 public:
  ${resource_class_name}() = delete;
  static std::uint8_t     Data[];
  static std::size_t      Size;
  static std::string_view Path;
};")
endfunction()

function(_get_resource_source_path resource_dir resource_file)
  _get_resource_source_dir()
  set(source_file ${resource_file})
  string_replace ("/" "_" ${source_file} source_file)
  string_replace ("." "_" ${source_file} source_file)
  to_snake_case  (          source_file ${source_file})
  set(resource_source_path ${resource_source_dir}/${resource_dir}/${source_file}.cc PARENT_SCOPE)
endfunction()

function(_get_resource_file_content resource_dir resource_file)
  _get_resource_output_path(${resource_dir} ${resource_file})
  file(READ ${resource_output_path} resource_file_content HEX)
  string_regex_matchall(.. ${resource_file_content} resource_file_content)
  set(resource_file_content ${resource_file_content} PARENT_SCOPE)
endfunction()

function(_get_resource_data resource_dir resource_file)
  _get_resource_file_content(${resource_dir} ${resource_file})
  foreach(byte ${resource_file_content})
    string(APPEND resource_data "0x${byte},")
  endforeach()
  set(resource_data ${resource_data} PARENT_SCOPE)
endfunction()

function(_create_resource_source resource_dir resource_file)
  _get_resource_header_path (${resource_dir} ${resource_file})
  _get_resource_source_path (${resource_dir} ${resource_file})
  _get_resource_class_name  (${resource_dir} ${resource_file})
  _get_resource_output_path (${resource_dir} ${resource_file})
  _get_resource_data        (${resource_dir} ${resource_file})

  file(WRITE ${resource_source_path} "
#include <${resource_header_path}>

std::uint8_t     ${resource_class_name}::Data[] = {${resource_data}};
std::size_t      ${resource_class_name}::Size   = sizeof(${resource_class_name}::Data);
std::string_view ${resource_class_name}::Path   = \"${resource_output_path}\";
  ")
endfunction()

function(_copy_resource resource_dir resource_file)
  _get_resource_input_path(${resource_dir} ${resource_file})
  _get_resource_binary_dir(${resource_dir})
  file(COPY ${resource_input_path} DESTINATION ${resource_binary_dir}/${resource_dir})
endfunction()

function(_add_resource_source target resource_dir resource_file)
  _get_resource_source_path(${resource_dir} ${resource_file})
  target_sources(${target} PRIVATE ${resource_source_path})
endfunction()

function(_add_single_resource target resource_dir resource_file)
  _copy_resource          (          ${resource_dir} ${resource_file})
  _create_resource_header (          ${resource_dir} ${resource_file})
  _create_resource_source (          ${resource_dir} ${resource_file})
  _add_resource_source    (${target} ${resource_dir} ${resource_file})
endfunction()

function(_add_resource_headers target resource_dir)
  _get_resource_header_dir()
  add_build_headers(${target} ${resource_header_dir})
endfunction()

function(_add_multi_resource target resource_dir)
  foreach(resource_file ${ARGN})
    _add_single_resource(${target} ${resource_dir} ${resource_file})
  endforeach()
  _add_resource_headers(${target} ${resource_dir})
endfunction()

function(add_executable_resources target_exe)
  _add_multi_resource(${target_exe}-exe ${ARGN})
endfunction()

function(add_library_resources target_lib)
  _add_multi_resource(${target_lib}-lib ${ARGN})
endfunction()

function(add_test_resources target_test)
  _add_multi_resource(${target_test}-test ${ARGN})
endfunction()
