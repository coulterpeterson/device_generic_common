#
# BoardConfig.mk for x86 platform
#

ANDROID_JACK_VM_ARGS := -Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx5096m
JAVA_TOOL_OPTIONS := -Dfile.encoding=UTF8

TARGET_BOARD_PLATFORM := android-x86

# Some framework code requires this to enable BT
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_LINUX := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/generic/common/bluetooth

BOARD_USE_LEGACY_UI := true

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 4047483648
#BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := squashfs
#BOARD_SYSTEMIMAGE_SQUASHFS_COMPRESSOR := gzip
#TARGET_USERIMAGES_SPARSE_SQUASHFS_DISABLED := true

# customize the malloced address to be 16-byte aligned
BOARD_MALLOC_ALIGNMENT := 16

# Enable dex-preoptimization to speed up the first boot sequence
# of an SDK AVD. Note that this operation only works on Linux for now
# ifeq ($(HOST_OS),linux)
# WITH_DEXPREOPT := true
# WITH_DEXPREOPT_PIC := true
# endif

# Enable for deodex ROM
#WITH_DEXPREOPT := false
#WITH_DEXPREOPT_PIC := false

# the following variables could be overridden
TARGET_PRELINK_MODULE := false
TARGET_NO_KERNEL ?= false
TARGET_NO_RECOVERY ?= true
TARGET_EXTRA_KERNEL_MODULES := tp_smapi
ifneq ($(filter efi_img,$(MAKECMDGOALS)),)
TARGET_KERNEL_ARCH ?= x86_64
endif
TARGET_USES_64_BIT_BINDER := true

ifeq ($(PC_RECOVERY),true)
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
    boot \
    system
AB_OTA_PARTITIONS += vbmeta
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_SLOT_AB_ENABLE := true
TARGET_RECOVERY_FSTAB ?= $(TARGET_DEVICE_DIR)/fstab.recovery
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
endif

# ifneq ($(KERNEL_VERSION) > 4.15,)
# BUILD_KERNEL_WITH_CLANG := true
# endif

BOARD_USES_GENERIC_AUDIO ?= false
BOARD_USES_ALSA_AUDIO ?= true
BUILD_WITH_ALSA_UTILS ?= true
BOARD_HAS_GPS_HARDWARE ?= true

# Don't build emulator
BUILD_EMULATOR ?= false
BUILD_STANDALONE_EMULATOR ?= false
BUILD_EMULATOR_QEMUD ?= false
BUILD_EMULATOR_OPENGL ?= false
BUILD_EMULATOR_OPENGL_DRIVER ?= false
BUILD_EMULATOR_QEMU_PROPS ?= false
BUILD_EMULATOR_CAMERA_HAL ?= false
BUILD_EMULATOR_GPS_MODULE ?= false
BUILD_EMULATOR_LIGHTS_MODULE ?= false
BUILD_EMULATOR_SENSORS_MODULE ?= false

ifneq ("$(wildcard vendor/intel/houdini/*)","")
	HOUDINI_PREINSTALL := intel
	ENABLE_UNITY_REPLACEMENT := true
	#~ -include vendor/intel/houdini/BoardConfig.mk
endif
	
BUILD_ARM_FOR_X86 := $(WITH_NATIVE_BRIDGE)

BOARD_USE_LIBVA_INTEL_DRIVER := true
BOARD_USE_LIBVA := true
BOARD_USE_LIBMIX := true
BOARD_USES_WRS_OMXIL_CORE := true
USE_INTEL_OMX_COMPONENTS := true

USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS ?= 3
BOARD_USES_DRM_HWCOMPOSER ?= true
SF_START_GRAPHICS_ALLOCATOR_SERVICE := true

# New for Pie
BOARD_USES_DRM_GRALLOC ?= true
TARGET_USES_HWC2 ?= true

USE_CAMERA_STUB ?= false

SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.cyanogenmod.superuser

# This enables the wpa wireless driver
BOARD_WPA_SUPPLICANT_DRIVER ?= NL80211
WPA_SUPPLICANT_VERSION ?= VER_2_1_DEVEL

BOARD_GPU_DRIVERS ?= crocus i965 iris nouveau r300g r600g radeonsi virgl vmwgfx
ifneq ($(strip $(BOARD_GPU_DRIVERS)),)
TARGET_HARDWARE_3D := true
endif

BOARD_KERNEL_CMDLINE := root=/dev/ram0 androidboot.selinux=permissive androidboot.hardware=$(TARGET_PRODUCT) $(if $(filter x86_64,$(TARGET_ARCH) $(TARGET_KERNEL_ARCH)),,vmalloc=192M)
TARGET_KERNEL_DIFFCONFIG := device/generic/common/selinux_diffconfig

COMPATIBILITY_ENHANCEMENT_PACKAGE := true
PRC_COMPATIBILITY_PACKAGE := true
ZIP_OPTIMIZATION_NO_INTEGRITY := true

DEVICE_MANIFEST_FILE := device/generic/common/manifest.xml

BOARD_SEPOLICY_DIRS += device/generic/common/sepolicy/nonplat \
                       system/bt/vendor_libs/linux/sepolicy \

SELINUX_IGNORE_NEVERALLOWS := true
# Vendor Interface Manifest
# DEVICE_MATRIX_FILE := device/generic/common/compatibility_matrix.xml

BOARD_PLAT_PRIVATE_SEPOLICY_DIR := device/generic/common/sepolicy/plat_private

BOARD_USES_MINIGBM := true
BOARD_USES_MINIGBM_INTEL := true
BOARD_USES_GRALLOC1 := true
BOARD_USES_IA_HWCOMPOSER := true
TARGET_USES_HWC2 ?= true
#BOARD_USES_VULKAN := true

# Bliss optimizations
WITH_BLISS_CHARGER := false
TARGET_PC_BUILD := true

# Bliss OS specific 
VER := 11.13
RELEASE_OS_TITLE := Bliss-OS
BLISS_BUILD := bliss-x86
BUILD_NAME_VARIANT := bliss-x86 
INSTALL_PREFIX := bliss-x86-$(VER) 
PREV_VERS := bliss-x86-6.4 bliss-x86-7.1.2 bliss-x86-8.0 bliss-x86-10.0 bliss-x86-10.1 bliss-x86-11.0 bliss-x86-11.1 bliss-x86-11.2 bliss-x86-11.3 bliss-x86-11.4 bliss-x86-11.5 bliss-x86-11.6 
BLISS_VERSION_MAINTENANCE := Stable-Dev
BLISSIFY := true
BLISS_GRAPHITE := true
BLISS_STRICT := false
FLOOP_NEST_OPTIMIZE := true
BLISS_PIPE := true
BLISS_GOMP := true
BLISS_EXTRAGCC := true
FAST_MATH := true
LINK_TIME_OPTIMIZATIONS := true
