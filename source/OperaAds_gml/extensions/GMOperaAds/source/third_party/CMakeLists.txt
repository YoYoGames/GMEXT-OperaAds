cmake_minimum_required(VERSION 3.18)

# -----------------------------------------------------------------------------
# Core "bag of usage requirements" your main target links to
# -----------------------------------------------------------------------------
add_library(ext_third_party INTERFACE)

# List of runtime files to bubble up to parent
set(_EXT_TP_RUNTIME_DLLS "")

# Helper macro to append runtime(s)
function(_ext_tp_append_runtime)
  foreach(_f IN LISTS ARGN)
    if(_f)
      list(APPEND _EXT_TP_RUNTIME_DLLS "${_f}")
    endif()
  endforeach()
  set(_EXT_TP_RUNTIME_DLLS
      "${_EXT_TP_RUNTIME_DLLS}"
      PARENT_SCOPE)
endfunction()

# =============================================================================
# WINDOWS (MSVC/ClangCL)
# =============================================================================
if(WIN32)
# =============================================================================
# APPLE: split macOS vs iOS/tvOS
# =============================================================================
elseif(APPLE)
  # ----------------------
  # iOS / tvOS (mobile)
  # ----------------------
  if((CMAKE_OSX_SYSROOT MATCHES "iphone"))

    get_filename_component(EXT_GM_PARENT_DIR "${EXT_GM_XCODEPROJ_OVERRIDE}" DIRECTORY)

    set(OPERAADS_XCFRAMEWORK "${EXT_GM_PARENT_DIR}/Pods/OpAdxSdk/OpAdxSdk.xcframework")

         #message(FATAL_ERROR "HERE: ${OPERAADS_XCFRAMEWORK} ???")


    if(NOT EXISTS "${OPERAADS_XCFRAMEWORK}")
      message(FATAL_ERROR "[third_party] Missing OperaAds XCFramework at: ${OPERAADS_XCFRAMEWORK}")
    endif()

    # ---- Choose the correct slice based on the SDK (device vs simulator) ----
    # CMAKE_OSX_SYSROOT typically contains iPhoneOS / iPhoneSimulator / AppleTVOS / AppleTVSimulator
    if(CMAKE_OSX_SYSROOT MATCHES "simulator")
      set(_SLICE_DIR "${OPERAADS_XCFRAMEWORK}/ios-arm64_x86_64-simulator")
      if(NOT EXISTS "${_SLICE_DIR}")
        # Some vendors use arm64-only simulator slices on newer toolchains
        set(_SLICE_DIR "${OPERAADS_XCFRAMEWORK}/ios-arm64-simulator")
      endif()
    else()
      set(_SLICE_DIR "${OPERAADS_XCFRAMEWORK}/ios-arm64")
    endif()

    if(NOT EXISTS "${_SLICE_DIR}")
      message(FATAL_ERROR
        "[third_party] Could not find a suitable OpAdxSdk slice.\n"
        "XCFramework: ${OPERAADS_XCFRAMEWORK}\n"
        "Tried slice: ${_SLICE_DIR}\n"
        "Sysroot: ${CMAKE_OSX_SYSROOT}"
      )
    endif()

    set(_FW_DIR "${_SLICE_DIR}/OpAdxSdk.framework")
    if(NOT EXISTS "${_FW_DIR}")
      message(FATAL_ERROR "[third_party] Missing framework directory: ${_FW_DIR}")
    endif()

    # Add framework search path for BOTH compile and link
    target_compile_options(ext_third_party INTERFACE
      "-F${_SLICE_DIR}"
    )

    target_link_options(ext_third_party INTERFACE
      "-F${_SLICE_DIR}"
    )

    # Link framework by name
    target_link_libraries(ext_third_party INTERFACE
      "-framework" "OpAdxSdk"
    )

    # If OpAdxSdk requires other Apple frameworks, add them here too:
    # target_link_libraries(ext_third_party INTERFACE "-framework" "AdSupport")

  # ----------------------
  # macOS (desktop)
  # ----------------------
  else()
  endif() # macOS

# =============================================================================
# ANDROID (AAR w/ Prefab or raw per-ABI .so)
# =============================================================================
elseif(ANDROID)
# =============================================================================
# LINUX (shared .so or static .a)
# =============================================================================
elseif(UNIX)
endif()

# =============================================================================
# Bubble up runtime list to parent
# =============================================================================
set(EXT_TP_RUNTIME_DLLS "${_EXT_TP_RUNTIME_DLLS}" PARENT_SCOPE)