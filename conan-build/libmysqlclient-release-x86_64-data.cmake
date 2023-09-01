########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(libmysqlclient_COMPONENT_NAMES "")
list(APPEND libmysqlclient_FIND_DEPENDENCY_NAMES OpenSSL ZLIB zstd lz4)
list(REMOVE_DUPLICATES libmysqlclient_FIND_DEPENDENCY_NAMES)
set(OpenSSL_FIND_MODE "NO_MODULE")
set(ZLIB_FIND_MODE "NO_MODULE")
set(zstd_FIND_MODE "NO_MODULE")
set(lz4_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(libmysqlclient_PACKAGE_FOLDER_RELEASE "/home/plaiseek/.conan2/p/b/libmy6eb0591a83c8c/p")
set(libmysqlclient_BUILD_MODULES_PATHS_RELEASE )


set(libmysqlclient_INCLUDE_DIRS_RELEASE )
set(libmysqlclient_RES_DIRS_RELEASE )
set(libmysqlclient_DEFINITIONS_RELEASE )
set(libmysqlclient_SHARED_LINK_FLAGS_RELEASE )
set(libmysqlclient_EXE_LINK_FLAGS_RELEASE )
set(libmysqlclient_OBJECTS_RELEASE )
set(libmysqlclient_COMPILE_DEFINITIONS_RELEASE )
set(libmysqlclient_COMPILE_OPTIONS_C_RELEASE )
set(libmysqlclient_COMPILE_OPTIONS_CXX_RELEASE )
set(libmysqlclient_LIB_DIRS_RELEASE "${libmysqlclient_PACKAGE_FOLDER_RELEASE}/lib")
set(libmysqlclient_BIN_DIRS_RELEASE )
set(libmysqlclient_LIBRARY_TYPE_RELEASE STATIC)
set(libmysqlclient_IS_HOST_WINDOWS_RELEASE 0)
set(libmysqlclient_LIBS_RELEASE mysqlclient)
set(libmysqlclient_SYSTEM_LIBS_RELEASE stdc++ m resolv)
set(libmysqlclient_FRAMEWORK_DIRS_RELEASE )
set(libmysqlclient_FRAMEWORKS_RELEASE )
set(libmysqlclient_BUILD_DIRS_RELEASE )
set(libmysqlclient_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(libmysqlclient_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${libmysqlclient_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${libmysqlclient_COMPILE_OPTIONS_C_RELEASE}>")
set(libmysqlclient_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libmysqlclient_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libmysqlclient_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libmysqlclient_EXE_LINK_FLAGS_RELEASE}>")


set(libmysqlclient_COMPONENTS_RELEASE )