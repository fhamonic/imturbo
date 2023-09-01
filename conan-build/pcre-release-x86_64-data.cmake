########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND pcre_COMPONENT_NAMES pcre::libpcre pcre::libpcreposix pcre::libpcre16 pcre::libpcre32)
list(REMOVE_DUPLICATES pcre_COMPONENT_NAMES)
list(APPEND pcre_FIND_DEPENDENCY_NAMES BZip2 ZLIB)
list(REMOVE_DUPLICATES pcre_FIND_DEPENDENCY_NAMES)
set(BZip2_FIND_MODE "NO_MODULE")
set(ZLIB_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(pcre_PACKAGE_FOLDER_RELEASE "/home/plaiseek/.conan2/p/b/pcre328fc57712592/p")
set(pcre_BUILD_MODULES_PATHS_RELEASE )


set(pcre_INCLUDE_DIRS_RELEASE )
set(pcre_RES_DIRS_RELEASE )
set(pcre_DEFINITIONS_RELEASE "-DPCRE_STATIC=1")
set(pcre_SHARED_LINK_FLAGS_RELEASE )
set(pcre_EXE_LINK_FLAGS_RELEASE )
set(pcre_OBJECTS_RELEASE )
set(pcre_COMPILE_DEFINITIONS_RELEASE "PCRE_STATIC=1")
set(pcre_COMPILE_OPTIONS_C_RELEASE )
set(pcre_COMPILE_OPTIONS_CXX_RELEASE )
set(pcre_LIB_DIRS_RELEASE "${pcre_PACKAGE_FOLDER_RELEASE}/lib")
set(pcre_BIN_DIRS_RELEASE )
set(pcre_LIBRARY_TYPE_RELEASE STATIC)
set(pcre_IS_HOST_WINDOWS_RELEASE 0)
set(pcre_LIBS_RELEASE pcre32 pcre16 pcreposix pcre)
set(pcre_SYSTEM_LIBS_RELEASE )
set(pcre_FRAMEWORK_DIRS_RELEASE )
set(pcre_FRAMEWORKS_RELEASE )
set(pcre_BUILD_DIRS_RELEASE )
set(pcre_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(pcre_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${pcre_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${pcre_COMPILE_OPTIONS_C_RELEASE}>")
set(pcre_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${pcre_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${pcre_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${pcre_EXE_LINK_FLAGS_RELEASE}>")


set(pcre_COMPONENTS_RELEASE pcre::libpcre pcre::libpcreposix pcre::libpcre16 pcre::libpcre32)
########### COMPONENT pcre::libpcre32 VARIABLES ############################################

set(pcre_pcre_libpcre32_INCLUDE_DIRS_RELEASE )
set(pcre_pcre_libpcre32_LIB_DIRS_RELEASE "${pcre_PACKAGE_FOLDER_RELEASE}/lib")
set(pcre_pcre_libpcre32_BIN_DIRS_RELEASE )
set(pcre_pcre_libpcre32_LIBRARY_TYPE_RELEASE STATIC)
set(pcre_pcre_libpcre32_IS_HOST_WINDOWS_RELEASE 0)
set(pcre_pcre_libpcre32_RES_DIRS_RELEASE )
set(pcre_pcre_libpcre32_DEFINITIONS_RELEASE "-DPCRE_STATIC=1")
set(pcre_pcre_libpcre32_OBJECTS_RELEASE )
set(pcre_pcre_libpcre32_COMPILE_DEFINITIONS_RELEASE "PCRE_STATIC=1")
set(pcre_pcre_libpcre32_COMPILE_OPTIONS_C_RELEASE "")
set(pcre_pcre_libpcre32_COMPILE_OPTIONS_CXX_RELEASE "")
set(pcre_pcre_libpcre32_LIBS_RELEASE pcre32)
set(pcre_pcre_libpcre32_SYSTEM_LIBS_RELEASE )
set(pcre_pcre_libpcre32_FRAMEWORK_DIRS_RELEASE )
set(pcre_pcre_libpcre32_FRAMEWORKS_RELEASE )
set(pcre_pcre_libpcre32_DEPENDENCIES_RELEASE )
set(pcre_pcre_libpcre32_SHARED_LINK_FLAGS_RELEASE )
set(pcre_pcre_libpcre32_EXE_LINK_FLAGS_RELEASE )
set(pcre_pcre_libpcre32_NO_SONAME_MODE_RELEASE FALSE)

# COMPOUND VARIABLES
set(pcre_pcre_libpcre32_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${pcre_pcre_libpcre32_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${pcre_pcre_libpcre32_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${pcre_pcre_libpcre32_EXE_LINK_FLAGS_RELEASE}>
)
set(pcre_pcre_libpcre32_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${pcre_pcre_libpcre32_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${pcre_pcre_libpcre32_COMPILE_OPTIONS_C_RELEASE}>")
########### COMPONENT pcre::libpcre16 VARIABLES ############################################

set(pcre_pcre_libpcre16_INCLUDE_DIRS_RELEASE )
set(pcre_pcre_libpcre16_LIB_DIRS_RELEASE "${pcre_PACKAGE_FOLDER_RELEASE}/lib")
set(pcre_pcre_libpcre16_BIN_DIRS_RELEASE )
set(pcre_pcre_libpcre16_LIBRARY_TYPE_RELEASE STATIC)
set(pcre_pcre_libpcre16_IS_HOST_WINDOWS_RELEASE 0)
set(pcre_pcre_libpcre16_RES_DIRS_RELEASE )
set(pcre_pcre_libpcre16_DEFINITIONS_RELEASE "-DPCRE_STATIC=1")
set(pcre_pcre_libpcre16_OBJECTS_RELEASE )
set(pcre_pcre_libpcre16_COMPILE_DEFINITIONS_RELEASE "PCRE_STATIC=1")
set(pcre_pcre_libpcre16_COMPILE_OPTIONS_C_RELEASE "")
set(pcre_pcre_libpcre16_COMPILE_OPTIONS_CXX_RELEASE "")
set(pcre_pcre_libpcre16_LIBS_RELEASE pcre16)
set(pcre_pcre_libpcre16_SYSTEM_LIBS_RELEASE )
set(pcre_pcre_libpcre16_FRAMEWORK_DIRS_RELEASE )
set(pcre_pcre_libpcre16_FRAMEWORKS_RELEASE )
set(pcre_pcre_libpcre16_DEPENDENCIES_RELEASE )
set(pcre_pcre_libpcre16_SHARED_LINK_FLAGS_RELEASE )
set(pcre_pcre_libpcre16_EXE_LINK_FLAGS_RELEASE )
set(pcre_pcre_libpcre16_NO_SONAME_MODE_RELEASE FALSE)

# COMPOUND VARIABLES
set(pcre_pcre_libpcre16_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${pcre_pcre_libpcre16_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${pcre_pcre_libpcre16_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${pcre_pcre_libpcre16_EXE_LINK_FLAGS_RELEASE}>
)
set(pcre_pcre_libpcre16_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${pcre_pcre_libpcre16_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${pcre_pcre_libpcre16_COMPILE_OPTIONS_C_RELEASE}>")
########### COMPONENT pcre::libpcreposix VARIABLES ############################################

set(pcre_pcre_libpcreposix_INCLUDE_DIRS_RELEASE )
set(pcre_pcre_libpcreposix_LIB_DIRS_RELEASE "${pcre_PACKAGE_FOLDER_RELEASE}/lib")
set(pcre_pcre_libpcreposix_BIN_DIRS_RELEASE )
set(pcre_pcre_libpcreposix_LIBRARY_TYPE_RELEASE STATIC)
set(pcre_pcre_libpcreposix_IS_HOST_WINDOWS_RELEASE 0)
set(pcre_pcre_libpcreposix_RES_DIRS_RELEASE )
set(pcre_pcre_libpcreposix_DEFINITIONS_RELEASE )
set(pcre_pcre_libpcreposix_OBJECTS_RELEASE )
set(pcre_pcre_libpcreposix_COMPILE_DEFINITIONS_RELEASE )
set(pcre_pcre_libpcreposix_COMPILE_OPTIONS_C_RELEASE "")
set(pcre_pcre_libpcreposix_COMPILE_OPTIONS_CXX_RELEASE "")
set(pcre_pcre_libpcreposix_LIBS_RELEASE pcreposix)
set(pcre_pcre_libpcreposix_SYSTEM_LIBS_RELEASE )
set(pcre_pcre_libpcreposix_FRAMEWORK_DIRS_RELEASE )
set(pcre_pcre_libpcreposix_FRAMEWORKS_RELEASE )
set(pcre_pcre_libpcreposix_DEPENDENCIES_RELEASE pcre::libpcre)
set(pcre_pcre_libpcreposix_SHARED_LINK_FLAGS_RELEASE )
set(pcre_pcre_libpcreposix_EXE_LINK_FLAGS_RELEASE )
set(pcre_pcre_libpcreposix_NO_SONAME_MODE_RELEASE FALSE)

# COMPOUND VARIABLES
set(pcre_pcre_libpcreposix_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${pcre_pcre_libpcreposix_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${pcre_pcre_libpcreposix_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${pcre_pcre_libpcreposix_EXE_LINK_FLAGS_RELEASE}>
)
set(pcre_pcre_libpcreposix_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${pcre_pcre_libpcreposix_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${pcre_pcre_libpcreposix_COMPILE_OPTIONS_C_RELEASE}>")
########### COMPONENT pcre::libpcre VARIABLES ############################################

set(pcre_pcre_libpcre_INCLUDE_DIRS_RELEASE )
set(pcre_pcre_libpcre_LIB_DIRS_RELEASE "${pcre_PACKAGE_FOLDER_RELEASE}/lib")
set(pcre_pcre_libpcre_BIN_DIRS_RELEASE )
set(pcre_pcre_libpcre_LIBRARY_TYPE_RELEASE STATIC)
set(pcre_pcre_libpcre_IS_HOST_WINDOWS_RELEASE 0)
set(pcre_pcre_libpcre_RES_DIRS_RELEASE )
set(pcre_pcre_libpcre_DEFINITIONS_RELEASE "-DPCRE_STATIC=1")
set(pcre_pcre_libpcre_OBJECTS_RELEASE )
set(pcre_pcre_libpcre_COMPILE_DEFINITIONS_RELEASE "PCRE_STATIC=1")
set(pcre_pcre_libpcre_COMPILE_OPTIONS_C_RELEASE "")
set(pcre_pcre_libpcre_COMPILE_OPTIONS_CXX_RELEASE "")
set(pcre_pcre_libpcre_LIBS_RELEASE pcre)
set(pcre_pcre_libpcre_SYSTEM_LIBS_RELEASE )
set(pcre_pcre_libpcre_FRAMEWORK_DIRS_RELEASE )
set(pcre_pcre_libpcre_FRAMEWORKS_RELEASE )
set(pcre_pcre_libpcre_DEPENDENCIES_RELEASE BZip2::BZip2 ZLIB::ZLIB)
set(pcre_pcre_libpcre_SHARED_LINK_FLAGS_RELEASE )
set(pcre_pcre_libpcre_EXE_LINK_FLAGS_RELEASE )
set(pcre_pcre_libpcre_NO_SONAME_MODE_RELEASE FALSE)

# COMPOUND VARIABLES
set(pcre_pcre_libpcre_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${pcre_pcre_libpcre_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${pcre_pcre_libpcre_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${pcre_pcre_libpcre_EXE_LINK_FLAGS_RELEASE}>
)
set(pcre_pcre_libpcre_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${pcre_pcre_libpcre_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${pcre_pcre_libpcre_COMPILE_OPTIONS_C_RELEASE}>")