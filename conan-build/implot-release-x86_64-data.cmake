########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(implot_COMPONENT_NAMES "")
list(APPEND implot_FIND_DEPENDENCY_NAMES imgui)
list(REMOVE_DUPLICATES implot_FIND_DEPENDENCY_NAMES)
set(imgui_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(implot_PACKAGE_FOLDER_RELEASE "/home/plaiseek/.conan2/p/b/implo52a1d89c00e1f/p")
set(implot_BUILD_MODULES_PATHS_RELEASE )


set(implot_INCLUDE_DIRS_RELEASE "${implot_PACKAGE_FOLDER_RELEASE}/include")
set(implot_RES_DIRS_RELEASE )
set(implot_DEFINITIONS_RELEASE )
set(implot_SHARED_LINK_FLAGS_RELEASE )
set(implot_EXE_LINK_FLAGS_RELEASE )
set(implot_OBJECTS_RELEASE )
set(implot_COMPILE_DEFINITIONS_RELEASE )
set(implot_COMPILE_OPTIONS_C_RELEASE )
set(implot_COMPILE_OPTIONS_CXX_RELEASE )
set(implot_LIB_DIRS_RELEASE "${implot_PACKAGE_FOLDER_RELEASE}/lib")
set(implot_BIN_DIRS_RELEASE )
set(implot_LIBRARY_TYPE_RELEASE STATIC)
set(implot_IS_HOST_WINDOWS_RELEASE 0)
set(implot_LIBS_RELEASE implot)
set(implot_SYSTEM_LIBS_RELEASE )
set(implot_FRAMEWORK_DIRS_RELEASE )
set(implot_FRAMEWORKS_RELEASE )
set(implot_BUILD_DIRS_RELEASE )
set(implot_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(implot_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${implot_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${implot_COMPILE_OPTIONS_C_RELEASE}>")
set(implot_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${implot_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${implot_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${implot_EXE_LINK_FLAGS_RELEASE}>")


set(implot_COMPONENTS_RELEASE )