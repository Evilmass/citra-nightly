
# This function downloads a binary library package from our external repo.
# Params:
#   remote_path: path to the file to download, relative to the remote repository root
#   prefix_var: name of a variable which will be set with the path to the extracted contents
function(download_bundled_external remote_path lib_name prefix_var)
set(prefix "${CMAKE_BINARY_DIR}/externals/${lib_name}")
if (NOT EXISTS "${prefix}")
    set(download_url "https://github.com/Evilmass/ext-win-bin/raw/refs/heads/main/${remote_path}${lib_name}.7z")
    message(STATUS "URL: ${download_url}")
    message(STATUS "Downloading binaries for ${lib_name}...")
    file(DOWNLOAD
        ${download_url}
        "${CMAKE_BINARY_DIR}/externals/${lib_name}.7z"
        SHOW_PROGRESS)
    execute_process(COMMAND ${CMAKE_COMMAND} -E tar xf "${CMAKE_BINARY_DIR}/externals/${lib_name}.7z"
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/externals")
endif()
message(STATUS "Using bundled binaries at ${prefix}")
set(${prefix_var} "${prefix}" PARENT_SCOPE)
endfunction()