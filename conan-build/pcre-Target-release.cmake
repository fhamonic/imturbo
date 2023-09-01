# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(pcre_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(pcre_FRAMEWORKS_FOUND_RELEASE "${pcre_FRAMEWORKS_RELEASE}" "${pcre_FRAMEWORK_DIRS_RELEASE}")

set(pcre_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET pcre_DEPS_TARGET)
    add_library(pcre_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET pcre_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${pcre_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${pcre_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:BZip2::BZip2;ZLIB::ZLIB;pcre::libpcre>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### pcre_DEPS_TARGET to all of them
conan_package_library_targets("${pcre_LIBS_RELEASE}"    # libraries
                              "${pcre_LIB_DIRS_RELEASE}" # package_libdir
                              "${pcre_BIN_DIRS_RELEASE}" # package_bindir
                              "${pcre_LIBRARY_TYPE_RELEASE}"
                              "${pcre_IS_HOST_WINDOWS_RELEASE}"
                              pcre_DEPS_TARGET
                              pcre_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "pcre"    # package_name
                              "${pcre_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${pcre_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Release ########################################

    ########## COMPONENT pcre::libpcre32 #############

        set(pcre_pcre_libpcre32_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(pcre_pcre_libpcre32_FRAMEWORKS_FOUND_RELEASE "${pcre_pcre_libpcre32_FRAMEWORKS_RELEASE}" "${pcre_pcre_libpcre32_FRAMEWORK_DIRS_RELEASE}")

        set(pcre_pcre_libpcre32_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET pcre_pcre_libpcre32_DEPS_TARGET)
            add_library(pcre_pcre_libpcre32_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET pcre_pcre_libpcre32_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre32_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre32_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre32_DEPENDENCIES_RELEASE}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'pcre_pcre_libpcre32_DEPS_TARGET' to all of them
        conan_package_library_targets("${pcre_pcre_libpcre32_LIBS_RELEASE}"
                              "${pcre_pcre_libpcre32_LIB_DIRS_RELEASE}"
                              "${pcre_pcre_libpcre32_BIN_DIRS_RELEASE}" # package_bindir
                              "${pcre_pcre_libpcre32_LIBRARY_TYPE_RELEASE}"
                              "${pcre_pcre_libpcre32_IS_HOST_WINDOWS_RELEASE}"
                              pcre_pcre_libpcre32_DEPS_TARGET
                              pcre_pcre_libpcre32_LIBRARIES_TARGETS
                              "_RELEASE"
                              "pcre_pcre_libpcre32"
                              "${pcre_pcre_libpcre32_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET pcre::libpcre32
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre32_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre32_LIBRARIES_TARGETS}>
                     APPEND)

        if("${pcre_pcre_libpcre32_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET pcre::libpcre32
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         pcre_pcre_libpcre32_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET pcre::libpcre32 PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre32_LINKER_FLAGS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcre32 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre32_INCLUDE_DIRS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcre32 PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre32_LIB_DIRS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcre32 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre32_COMPILE_DEFINITIONS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcre32 PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre32_COMPILE_OPTIONS_RELEASE}> APPEND)

    ########## COMPONENT pcre::libpcre16 #############

        set(pcre_pcre_libpcre16_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(pcre_pcre_libpcre16_FRAMEWORKS_FOUND_RELEASE "${pcre_pcre_libpcre16_FRAMEWORKS_RELEASE}" "${pcre_pcre_libpcre16_FRAMEWORK_DIRS_RELEASE}")

        set(pcre_pcre_libpcre16_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET pcre_pcre_libpcre16_DEPS_TARGET)
            add_library(pcre_pcre_libpcre16_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET pcre_pcre_libpcre16_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre16_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre16_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre16_DEPENDENCIES_RELEASE}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'pcre_pcre_libpcre16_DEPS_TARGET' to all of them
        conan_package_library_targets("${pcre_pcre_libpcre16_LIBS_RELEASE}"
                              "${pcre_pcre_libpcre16_LIB_DIRS_RELEASE}"
                              "${pcre_pcre_libpcre16_BIN_DIRS_RELEASE}" # package_bindir
                              "${pcre_pcre_libpcre16_LIBRARY_TYPE_RELEASE}"
                              "${pcre_pcre_libpcre16_IS_HOST_WINDOWS_RELEASE}"
                              pcre_pcre_libpcre16_DEPS_TARGET
                              pcre_pcre_libpcre16_LIBRARIES_TARGETS
                              "_RELEASE"
                              "pcre_pcre_libpcre16"
                              "${pcre_pcre_libpcre16_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET pcre::libpcre16
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre16_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre16_LIBRARIES_TARGETS}>
                     APPEND)

        if("${pcre_pcre_libpcre16_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET pcre::libpcre16
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         pcre_pcre_libpcre16_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET pcre::libpcre16 PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre16_LINKER_FLAGS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcre16 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre16_INCLUDE_DIRS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcre16 PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre16_LIB_DIRS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcre16 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre16_COMPILE_DEFINITIONS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcre16 PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre16_COMPILE_OPTIONS_RELEASE}> APPEND)

    ########## COMPONENT pcre::libpcreposix #############

        set(pcre_pcre_libpcreposix_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(pcre_pcre_libpcreposix_FRAMEWORKS_FOUND_RELEASE "${pcre_pcre_libpcreposix_FRAMEWORKS_RELEASE}" "${pcre_pcre_libpcreposix_FRAMEWORK_DIRS_RELEASE}")

        set(pcre_pcre_libpcreposix_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET pcre_pcre_libpcreposix_DEPS_TARGET)
            add_library(pcre_pcre_libpcreposix_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET pcre_pcre_libpcreposix_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcreposix_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${pcre_pcre_libpcreposix_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${pcre_pcre_libpcreposix_DEPENDENCIES_RELEASE}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'pcre_pcre_libpcreposix_DEPS_TARGET' to all of them
        conan_package_library_targets("${pcre_pcre_libpcreposix_LIBS_RELEASE}"
                              "${pcre_pcre_libpcreposix_LIB_DIRS_RELEASE}"
                              "${pcre_pcre_libpcreposix_BIN_DIRS_RELEASE}" # package_bindir
                              "${pcre_pcre_libpcreposix_LIBRARY_TYPE_RELEASE}"
                              "${pcre_pcre_libpcreposix_IS_HOST_WINDOWS_RELEASE}"
                              pcre_pcre_libpcreposix_DEPS_TARGET
                              pcre_pcre_libpcreposix_LIBRARIES_TARGETS
                              "_RELEASE"
                              "pcre_pcre_libpcreposix"
                              "${pcre_pcre_libpcreposix_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET pcre::libpcreposix
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcreposix_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${pcre_pcre_libpcreposix_LIBRARIES_TARGETS}>
                     APPEND)

        if("${pcre_pcre_libpcreposix_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET pcre::libpcreposix
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         pcre_pcre_libpcreposix_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET pcre::libpcreposix PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${pcre_pcre_libpcreposix_LINKER_FLAGS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcreposix PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcreposix_INCLUDE_DIRS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcreposix PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcreposix_LIB_DIRS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcreposix PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${pcre_pcre_libpcreposix_COMPILE_DEFINITIONS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcreposix PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${pcre_pcre_libpcreposix_COMPILE_OPTIONS_RELEASE}> APPEND)

    ########## COMPONENT pcre::libpcre #############

        set(pcre_pcre_libpcre_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(pcre_pcre_libpcre_FRAMEWORKS_FOUND_RELEASE "${pcre_pcre_libpcre_FRAMEWORKS_RELEASE}" "${pcre_pcre_libpcre_FRAMEWORK_DIRS_RELEASE}")

        set(pcre_pcre_libpcre_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET pcre_pcre_libpcre_DEPS_TARGET)
            add_library(pcre_pcre_libpcre_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET pcre_pcre_libpcre_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre_DEPENDENCIES_RELEASE}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'pcre_pcre_libpcre_DEPS_TARGET' to all of them
        conan_package_library_targets("${pcre_pcre_libpcre_LIBS_RELEASE}"
                              "${pcre_pcre_libpcre_LIB_DIRS_RELEASE}"
                              "${pcre_pcre_libpcre_BIN_DIRS_RELEASE}" # package_bindir
                              "${pcre_pcre_libpcre_LIBRARY_TYPE_RELEASE}"
                              "${pcre_pcre_libpcre_IS_HOST_WINDOWS_RELEASE}"
                              pcre_pcre_libpcre_DEPS_TARGET
                              pcre_pcre_libpcre_LIBRARIES_TARGETS
                              "_RELEASE"
                              "pcre_pcre_libpcre"
                              "${pcre_pcre_libpcre_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET pcre::libpcre
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre_LIBRARIES_TARGETS}>
                     APPEND)

        if("${pcre_pcre_libpcre_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET pcre::libpcre
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         pcre_pcre_libpcre_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET pcre::libpcre PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre_LINKER_FLAGS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcre PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre_INCLUDE_DIRS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcre PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre_LIB_DIRS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcre PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre_COMPILE_DEFINITIONS_RELEASE}> APPEND)
        set_property(TARGET pcre::libpcre PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${pcre_pcre_libpcre_COMPILE_OPTIONS_RELEASE}> APPEND)

    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET pcre::pcre PROPERTY INTERFACE_LINK_LIBRARIES pcre::libpcre32 APPEND)
    set_property(TARGET pcre::pcre PROPERTY INTERFACE_LINK_LIBRARIES pcre::libpcre16 APPEND)
    set_property(TARGET pcre::pcre PROPERTY INTERFACE_LINK_LIBRARIES pcre::libpcreposix APPEND)
    set_property(TARGET pcre::pcre PROPERTY INTERFACE_LINK_LIBRARIES pcre::libpcre APPEND)

########## For the modules (FindXXX)
set(pcre_LIBRARIES_RELEASE pcre::pcre)
