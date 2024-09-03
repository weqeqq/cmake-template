#!/usr/bin/bash
IFS=$'\n'

message() {
    printf "${1}\n"
}
color_message() {
    message "\033[${1}m${2}\033[0m"
}
red_message() {
    color_message "0;31" ${1}
}
green_message() {
    color_message "1;32" ${1}
}

xdg_cache_home() {
    if [ ! -v "XDG_CACHE_HOME" ] && [ -z "$XDG_CACHE_HOME" ]; then
        XDG_CACHE_HOME="$HOME/.cache"
    fi
}
remove_cmake_template() {
    if [ -d "$XDG_CACHE_HOME/cmake-template" ]; then
        message "Removing downloaded CMake template directory..." ]
        rm -rf "${XDG_CACHE_HOME}/cmake-template"
    fi
}
prepare() {
    xdg_cache_home
    remove_cmake_template
}

download_cmake_template() {
    green_message "Downloading CMake template..."
    git clone --quiet "git@github.com:weqeqq/cmake-template.git" "$XDG_CACHE_HOME/cmake-template"
}

remove_cmake_presets_file() {
    message "Removing CMakePresets.json file..."
    if [ -f "CMakePresets.json" ]; then
        rm "CMakePresets.json"
    fi
}
copy_downloaded_cmake_presets_file() {
    message "Copying downloaded CMakePresets.json file..."
    cp "${XDG_CACHE_HOME}/cmake-template/CMakePresets.json" "CMakePresets.json"
}
install_cmake_presets_file() {
    green_message "Installing CMakePresets.json file..."
    remove_cmake_presets_file
    copy_downloaded_cmake_presets_file
}

remove_cmake_directory() {
    message "Removing CMake directory..."
    if [ -d "cmake" ]; then
        rm -rf "cmake"
    fi
}
copy_downloaded_cmake_directory() {
    message "Copying downloaded CMake directory..."
    cp -r "${XDG_CACHE_HOME}/cmake-template/cmake" "cmake"
}
install_cmake_directory() {
    green_message "Installing CMake directory..."
    remove_cmake_directory
    copy_downloaded_cmake_directory
}

update_cmake_template() {
    green_message "Updating CMake template..."
    download_cmake_template
    install_cmake_presets_file
    install_cmake_directory
}

prepare
update_cmake_template
green_message "CMake template updated successfully!"
