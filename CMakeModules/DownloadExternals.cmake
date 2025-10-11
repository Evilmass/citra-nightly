# This function downloads a binary library package from our external repo.
# Params:
#   remote_path: path to the file to download, relative to the remote repository root
#   lib_name: name of the library (used for naming local files)
#   prefix_var: name of a variable which will be set with the path to the extracted contents
function(download_bundled_external remote_path lib_name prefix_var)
    set(prefix "${CMAKE_BINARY_DIR}/externals/${lib_name}")
    set(archive "${CMAKE_BINARY_DIR}/externals/${lib_name}.7z")
    set(url "https://github.com/Evilmass/ext-win-bin/raw/main/${remote_path}${lib_name}.7z")

    # Download archive if missing
    if(NOT EXISTS "${archive}")
        message(STATUS "Downloading ${lib_name} from ${url}")
        file(DOWNLOAD ${url} "${archive}" SHOW_PROGRESS TIMEOUT 300)
    endif()

    # Extract archive if needed
    if(NOT EXISTS "${prefix}")
        message(STATUS "Extracting ${archive} to ${prefix}")
        execute_process(COMMAND ${CMAKE_COMMAND} -E tar xvf "${archive}"
            WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/externals")
    endif()

    set(${prefix_var} "${prefix}" PARENT_SCOPE)
endfunction()