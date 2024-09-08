
include(GenerateExportHeader)
include(Base/Property)

include(Dependency)
include(Resources)
include(Sources)
include(Headers)

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

function(_add_library_headers target_lib)
  add_build_headers(${target_lib}-lib ${CMAKE_CURRENT_SOURCE_DIR}/headers)
endfunction()

function(_add_library_export target_lib)
  add_build_headers(${target_lib}-lib ${CMAKE_CURRENT_BINARY_DIR}/export)
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
  _add_library_export           (${target_lib})
endfunction()

function(create_library target_lib)
  _add_library             (${target_lib})
  _setup_library           (${target_lib})
  _add_export_header       (${target_lib})
  _add_library_headers     (${target_lib})
endfunction()
