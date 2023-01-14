cmake_minimum_required(VERSION 3.12)
project(STM32F4Discovery-CMSIS C CXX ASM)

# CONFIGURATION ------------------------------------------------------------------------------------
set(STM32CUBE_DIR "C:/SDKs/STM32Cube_FW_F4_V1.27.0")
set(STM32CUBE_CMSIS_DIR ${STM32CUBE_DIR}/Drivers/CMSIS/Device/ST/STM32F4xx)

# Include directories
set(INCLUDE_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${STM32CUBE_CMSIS_DIR}/Include
    ${STM32CUBE_DIR}/Drivers/CMSIS/Core/Include
)

# Source files
set(SRCS
    ${CMAKE_CURRENT_SOURCE_DIR}/src/main.c
    ${STM32CUBE_CMSIS_DIR}/Source/Templates/gcc/startup_stm32f407xx.s
    ${STM32CUBE_CMSIS_DIR}/Source/Templates/system_stm32f4xx.c
)

set(DEFS
    STM32F407xx)

# MCU-specific compilation options (used for both compiling and linking)
set(MCU_OPTIONS
    -mcpu=cortex-m4
    -mlittle-endian
    -mfpu=fpv4-sp-d16
    -mfloat-abi=hard
    -mthumb
    -mthumb-interwork
)

# Compilation options that are not MCU specific
set(COMPILE_OPTIONS
    ${MCU_OPTIONS}
    -ggdb
    -Os
    -MD
    -ffunction-sections
    -fdata-sections
    -Wall
    --pedantic-errors
)

# Linking options that are not MCU specific
set(LINK_OPTIONS
    ${MCU_OPTIONS}
    -Wl,-T ${CMAKE_CURRENT_SOURCE_DIR}/device/STM32F407VGTx_FLASH.ld
    -Wl,--gc-sections
)

# INTERNALS ----------------------------------------------------------------------------------------

add_executable(${PROJECT_NAME} ${SRCS})

target_include_directories(${PROJECT_NAME} PRIVATE
    ${INCLUDE_DIRS}
)

target_compile_definitions(${PROJECT_NAME} PRIVATE
    ${DEFS}
)

target_compile_options(${PROJECT_NAME} PRIVATE
    ${COMPILE_OPTIONS}
)

target_link_options(${PROJECT_NAME} PRIVATE
    ${LINK_OPTIONS}
)

# CUSTOM -------------------------------------------------------------------------------------------

# Run objcopy post-build
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD COMMAND 
  ${CMAKE_OBJCOPY} -O binary ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}${CMAKE_EXECUTABLE_SUFFIX_C}
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.bin
)

# Add objcopy output to clean target
set_property(
    TARGET ${PROJECT_NAME}
    APPEND
    PROPERTY ADDITIONAL_CLEAN_FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.bin
)

# Make flashing the MCU convenient with a custom "flash" target
add_custom_target(flash DEPENDS ${PROJECT_NAME} COMMAND
    STM32_Programmer_CLI -c port=SWD -d ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.bin 0x08000000)
