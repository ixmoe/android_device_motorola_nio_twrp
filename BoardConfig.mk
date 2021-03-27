#
# Copyright 2021 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

PLATFORM_PATH := device/motorola/nio

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := kona
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Platform
BOARD_USES_QCOM_HARDWARE := true
QCOM_BOARD_PLATFORMS += kona
TARGET_BOARD_PLATFORM := kona
TARGET_BOARD_PLATFORM_GPU := qcom-adreno650
TARGET_USES_QCOM_BSP := true

TARGET_USES_64_BIT_BINDER := true
TARGET_SUPPORTS_64_BIT_APPS := true
BUILD_BROKEN_DUP_RULES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a76

# Enable CPUSets
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# GPT Utils
BOARD_PROVIDES_GPTUTILS := true

# Kernel
BOARD_KERNEL_CMDLINE := \
    console=ttyMSM0,115200n8 \
    earlycon=msm_geni_serial,0xa90000 \
    androidboot.hardware=qcom \
    androidboot.console=ttyMSM0 \
    androidboot.memcg=1 \
    lpm_levels.sleep_disabled=1 \
    video=vfb:640x400,bpp=32,memsize=3072000 \
    msm_rtb.filter=0x237 \
    service_locator.enable=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    swiotlb=2048 \
    cgroup.memory=nokmem,nosocket \
    reboot=panic_warm \
    firmware_class.path=/vendor/firmware_mnt/image
# For the love of all that is holy, please do not include this in your ROM unless you really want TWRP to not work correctly!
BOARD_KERNEL_CMDLINE += androidboot.fastboot=1 twrpfastboot=1
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE          := 0x00000000
BOARD_KERNEL_OFFSET        := 0x00008000
BOARD_RAMDISK_OFFSET       := 0x01000000
BOARD_KERNEL_SECOND_OFFSET := 0x00f00000
BOARD_KERNEL_TAGS_OFFSET   := 0x00000100
BOARD_DTB_OFFSET           := 0x01f00000
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

TARGET_KERNEL_SOURCE := kernel/motorola/sm8250
TARGET_KERNEL_CONFIG := vendor/nio_defconfig

BOARD_KERNEL_IMAGE_NAME := Image
BOARD_PREBUILT_DTBIMAGE_DIR := $(PLATFORM_PATH)/prebuilt
# TARGET_PREBUILT_KERNEL := $(PLATFORM_PATH)/prebuilt/$(BOARD_KERNEL_IMAGE_NAME)

TARGET_KERNEL_VERSION := 4.14
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

TARGET_KERNEL_CLANG_COMPILE := true
# TARGET_KERNEL_CLANG_VERSION := r328903

BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 949886976
BOARD_USERDATAIMAGE_PARTITION_SIZE := 241247563776
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
LZMA_RAMDISK_TARGETS := recovery

# Super
BOARD_SUPER_PARTITION_SIZE := 12884901888
BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 6441926656
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    product \
    vendor

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_LARGE_FILESYSTEM := true
# BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

# A/B device flags
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := false
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# TWRP specific build flags
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_RESETPROP := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_MAX_BRIGHTNESS := 4095
TW_DEFAULT_BRIGHTNESS := 2048
TW_THEME := portrait_hdpi
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TW_NO_SCREEN_BLANK := true

TW_OVERRIDE_SYSTEM_PROPS := \
    "ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental"

# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hidl.base@1.0 \
    ashmemd \
    ashmemd_aidl_interface-cpp \
    libashmemd_client \
    libcap \
    libicui18n \
    libicuuc \
    libion \
    libpcrecpp \
    libprocinfo \
    libxml2

TW_RECOVERY_ADDITIONAL_RELINK_BINARY_FILES += \
    $(TARGET_OUT_EXECUTABLES)/ashmemd

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.base@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/ashmemd_aidl_interface-cpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libashmemd_client.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libcap.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libicui18n.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libicuuc.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpcrecpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libprocinfo.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so

# Encryption
PLATFORM_VERSION := 16.1.0
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
TW_INCLUDE_CRYPTO := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true

# Extras
TARGET_SYSTEM_PROP += $(PLATFORM_PATH)/system.prop

BOARD_SUPPRESS_SECURE_ERASE := true
TW_USE_TOOLBOX := true
TW_EXCLUDE_TWRPAPP := true
TW_HAS_EDL_MODE := true

# Asian region languages
TW_EXTRA_LANGUAGES := true
# TW_DEFAULT_LANGUAGE := zh_CN

# Debug flags
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

ALLOW_MISSING_DEPENDENCIES := true
# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
