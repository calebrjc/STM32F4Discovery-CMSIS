# arm-none-eabi.cmake ------------------------------------------------------------------------------

# Set system variables
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Define tools
set(_toolchain_prefix "arm-none-eabi")
set(CMAKE_C_COMPILER ${_toolchain_prefix}-gcc)
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER ${_toolchain_prefix}-g++)
set(CMAKE_LINKER ${_toolchain_prefix}-ld)
set(CMAKE_OBJCOPY ${_toolchain_prefix}-objcopy)
set(CMAKE_SIZE ${_toolchain_prefix}-size)
set(CMAKE_OBJDUMP ${_toolchain_prefix}-objdump)

# Set binary file extension
set(CMAKE_EXECUTABLE_SUFFIX_ASM ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX ".elf")

# Don't force CMake to compile a full test program (skip some compiler checks)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Clear default CMake flags
set(CMAKE_C_FLAGS_DEBUG "")
set(CMAKE_C_FLAGS_RELEASE "")
set(CMAKE_CXX_FLAGS_DEBUG "")
set(CMAKE_CXX_FLAGS_RELEASE "")

# C Standard Configuration
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

# CXX Standard Configuration
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)
