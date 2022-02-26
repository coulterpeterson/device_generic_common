#
# Copyright (C) 2014-2016 The Android-x86 Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Boot animation
TARGET_SCREEN_HEIGHT := 1080
TARGET_SCREEN_WIDTH := 1080
TARGET_BOOTANIMATION_HALF_RES := true

# Include MindTheGapps Apps
$(call inherit-product-if-exists, vendor/gapps/x86/x86-vendor.mk)

#PRODUCT_COPY_FILES += \
#	vendor/bliss/prebuilt/common/etc/init.bliss.rc:system/etc/init/init.bliss.rc

ifeq ($(USE_FOSS),true)
$(call inherit-product-if-exists, vendor/foss/foss.mk)
endif

ifeq ($(USE_MAGISK),true)
$(call inherit-product, vendor/magisk/magisk.mk)

endif

#PRODUCT_PROPERTY_OVERRIDES := \
#PRODUCT_DEFAULT_PROPERTY_OVERRIDES := \
#    ro.config.notification_sound=Krypton.ogg \
#    ro.config.alarm_alert=Scandium.ogg \
#    ro.config.ringtone=Sceptrum.ogg

#EndCustomCrap

PRODUCT_DIR := $(dir $(lastword $(filter-out device/common/%,$(filter device/%,$(ALL_PRODUCTS)))))

PRODUCT_PROPERTY_OVERRIDES := \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10 \
    keyguard.no_require_sim=true \
    ro.com.android.dataroaming=true \
    media.sf.hwaccel=1 \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

PRODUCT_DEFAULT_PROPERTY_OVERRIDES := \
    ro.arch=x86 \
    persist.rtc_local_time=1 \

# LMKd
PRODUCT_PRODUCT_PROPERTIES += \
    ro.lmk.low=1001 \
    ro.lmk.medium=800 \
    ro.lmk.critical=0 \
    ro.lmk.critical_upgrade=false \
    ro.lmk.upgrade_pressure=100 \
    ro.lmk.downgrade_pressure=100 \
    ro.lmk.kill_heaviest_task=true \
    ro.lmk.kill_timeout_ms=100 \
    ro.lmk.use_minfree_levels=true

# Recents
PRODUCT_PROPERTY_OVERRIDES += \
    ro.recents.grid=true

# Use an x86 compatible mode for deep sleep
PRODUCT_PROPERTY_OVERRIDES += \
    ro.mot.deep.sleep.supported=true

PRODUCT_COPY_FILES := \
    vendor/gearlock/out/gri/gearlock:gearlock \
    $(if $(wildcard $(PRODUCT_DIR)init.rc),$(PRODUCT_DIR)init.rc:root/init.rc) \
    $(if $(wildcard $(PRODUCT_DIR)init.sh),$(PRODUCT_DIR),$(LOCAL_PATH)/)init.sh:system/etc/init.sh \
    $(if $(wildcard $(PRODUCT_DIR)modules.blacklist),$(PRODUCT_DIR),$(LOCAL_PATH)/)modules.blacklist:system/etc/modules.blacklist \
    $(if $(wildcard $(PRODUCT_DIR)fstab.$(TARGET_PRODUCT)),$(PRODUCT_DIR)fstab.$(TARGET_PRODUCT),$(LOCAL_PATH)/fstab.x86):root/fstab.$(TARGET_PRODUCT) \
    $(if $(wildcard $(PRODUCT_DIR)wpa_supplicant.conf),$(PRODUCT_DIR),$(LOCAL_PATH)/)wpa_supplicant.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant.conf \
    $(if $(wildcard $(PRODUCT_DIR)wpa_supplicant_overlay.conf),$(PRODUCT_DIR),$(LOCAL_PATH)/)wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    $(if $(wildcard $(PRODUCT_DIR)excluded-input-devices.xml),$(PRODUCT_DIR),$(LOCAL_PATH)/)excluded-input-devices.xml:system/etc/excluded-input-devices.xml \
    $(if $(wildcard $(PRODUCT_DIR)init.$(TARGET_PRODUCT).rc),$(PRODUCT_DIR)init.$(TARGET_PRODUCT).rc,$(LOCAL_PATH)/init.x86.rc):root/init.$(TARGET_PRODUCT).rc \
    $(if $(wildcard $(PRODUCT_DIR)ueventd.$(TARGET_PRODUCT).rc),$(PRODUCT_DIR)ueventd.$(TARGET_PRODUCT).rc,$(LOCAL_PATH)/ueventd.x86.rc):root/ueventd.$(TARGET_PRODUCT).rc \
    $(if $(wildcard vendor/bliss/prebuilt/common/etc/init.bliss.rc),vendor/bliss/prebuilt/common/etc/init.bliss.rc:root/init.bliss.rc) \
    $(if $(wildcard vendor/bliss/prebuilt/common/etc/init.blissupdater.rc),vendor/bliss/prebuilt/common/etc/init.blissupdater.rc:system/etc/init/init.blissupdater.rc)

$(foreach f,$(wildcard vendor/bliss/prebuilt/common/etc/init/*.rc),\
$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

$(foreach f,$(wildcard vendor/bliss/prebuilt/common/bin/*),\
$(eval PRODUCT_COPY_FILES += $(f):system/bin/$(notdir $f)))

$(foreach f,$(wildcard vendor/bliss/prebuilt/common/etc/init.d/*),\
$(eval PRODUCT_COPY_FILES += $(f):system/etc/init.d/$(notdir $f)))

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ppp/ip-up:system/etc/ppp/ip-up \
    $(LOCAL_PATH)/ppp/ip-down:system/etc/ppp/ip-down \
    $(LOCAL_PATH)/ppp/peers/gprs:system/etc/ppp/peers/gprs \
    $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml \
    device/sample/etc/apns-full-conf.xml:system/etc/apns-conf.xml \
    device/sample/etc/old-apns-conf.xml:system/etc/old-apns-conf.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_tv.xml:system/etc/media_codecs_google_tv.xml \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.gamepad.xml:system/etc/permissions/android.hardware.gamepad.xml \
    frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.activities_on_secondary_displays.xml:system/etc/permissions/android.software.activities_on_secondary_displays.xml \
    frameworks/native/data/etc/android.software.device_admin.xml:system/etc/permissions/android.software.device_admin.xml \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:system/etc/permissions/android.software.freeform_window_management.xml \
    frameworks/native/data/etc/android.software.activities_on_secondary_displays.xml:system/etc/permissions/android.software.activities_on_secondary_displays.xml \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.picture_in_picture.xml:system/etc/permissions/android.software.picture_in_picture.xml \
    frameworks/native/data/etc/android.software.print.xml:system/etc/permissions/android.software.print.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.software.sip.xml:system/etc/permissions/android.software.sip.xml \
    frameworks/native/data/etc/android.software.device_admin.xml:system/etc/permissions/android.software.device_admin.xml \
    frameworks/native/data/etc/android.software.webview.xml:system/etc/permissions/android.software.webview.xml \
    $(foreach f,$(wildcard $(LOCAL_PATH)/alsa/*),$(f):$(subst $(LOCAL_PATH),system/etc,$(f))) \
    $(foreach f,$(wildcard $(LOCAL_PATH)/idc/*.idc $(LOCAL_PATH)/keylayout/*.kl),$(f):$(subst $(LOCAL_PATH),system/usr,$(f))) \
    x86_installer/bin/Androidx86-Installv26.0003.exe:Androidx86-Installv26.0003.exe


# WIDEVINE OVERRIDES
# PRODUCT_COPY_FILES += \
#     $(LOCAL_PATH)/lib/drm/libdrmwvmplugin.so:system/vendor/lib/drm/libdrmwvmplugin.so \
#     $(LOCAL_PATH)/lib/mediadrm/libwvdrmengine.so:system/vendor/lib/mediadrm/libwvdrmengine.so \
#     $(LOCAL_PATH)/lib/mediadrm/libplayreadydrmplugin.so:system/vendor/lib/mediadrm/libplayreadydrmplugin.so \
#     $(LOCAL_PATH)/lib/libwvdrm_L1.so:system/vendor/lib/libwvdrm_L1.so \
#     $(LOCAL_PATH)/lib/libwvm.so:system/vendor/lib/libwvm.so \

# PRODUCT_PROPERTY_OVERRIDES += \
#     media.stagefright.less-secure=true \
#     drm.service.enabled=true \
#     ro.com.widevine.cachesize=16777216 \
#     media.amplayer.widevineenable=true


PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_CHARACTERISTICS := tablet
PRODUCT_SHIPPING_API_LEVEL := 19

PRODUCT_AAPT_CONFIG := normal large xlarge mdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay

# Don't dex preopt prebuilt apps that will be updated from Play Store
DONT_DEXPREOPT_PREBUILTS := true

# Telephony
# PRODUCT_PACKAGES += \
# 	telephony-ext

# PRODUCT_BOOT_JARS += \
# 	telephony-ext

# Build ims-ext-common package
# PRODUCT_PACKAGES += \
#   ims-ext-common

# Enable MultiWindow
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.debug.multi_window=true


# Inherit some common Bliss stuff.
$(call inherit-product, vendor/bliss/config/common.mk)
$(call inherit-product-if-exists, vendor/x86/addon.mk)

# Get Android 8.0 HIDL HALs
$(call inherit-product,$(LOCAL_PATH)/treble.mk)

# Get the firmwares
$(call inherit-product,device/generic/firmware/firmware.mk)

# Get the touchscreen calibration tool
$(call inherit-product-if-exists,external/tslib/tslib.mk)

# Get the alsa files
$(call inherit-product-if-exists,hardware/libaudio/alsa.mk)

# Get GPS configuration
$(call inherit-product-if-exists,device/common/gps/gps_as.mk)

# Get the hardware acceleration libraries
$(call inherit-product-if-exists,$(LOCAL_PATH)/gpu/gpu_mesa.mk)

# Get the sensors hals
$(call inherit-product-if-exists,hardware/libsensors/sensors.mk)

# Get tablet dalvik parameters
$(call inherit-product,frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

# Get GMS
GAPPS_VARIANT ?= pico
$(call inherit-product-if-exists,$(if $(wildcard vendor/google/products/gms.mk),vendor/google/products/gms.mk,vendor/opengapps/build/opengapps-packages.mk))

# Get native bridge settings
$(call inherit-product-if-exists,$(LOCAL_PATH)/nativebridge/nativebridge.mk)

$(call inherit-product,$(if $(wildcard $(PRODUCT_DIR)packages.mk),$(PRODUCT_DIR),$(LOCAL_PATH)/)packages.mk)

# Get proprietary files if any exists
# $(call inherit-product-if-exists,vendor/bliss_priv/device-vendor.mk)
$(call inherit-product-if-exists,vendor/boringdroid/boringdroid.mk)

# Widevine from ChromeOS
$(call inherit-product-if-exists, vendor/google/chromeos-x86/target/widevine.mk)

ifneq ("$(wildcard vendor/intel/houdini/*)","")
$(foreach f,$(wildcard vendor/google/chromeos-x86/proprietary/houdini/etc/binfmt_misc/*),\
	$(eval PRODUCT_COPY_FILES += $(f):$(PRODUCT_OUT)/system/etc/binfmt_misc/$(notdir $f)))
$(foreach f,$(wildcard vendor/google/chromeos-x86/proprietary/houdini/etc/binfmt_misc/*),\
	$(eval PRODUCT_COPY_FILES += $(f):$(PRODUCT_OUT)/system/vendor/etc/binfmt_misc/$(notdir $f)))
$(foreach f,$(wildcard vendor/google/chromeos-x86/proprietary/houdini/etc/init/*),\
	$(eval PRODUCT_COPY_FILES += $(f):$(PRODUCT_OUT)/system/etc/init/$(notdir $f)))
$(foreach f,$(wildcard vendor/google/chromeos-x86/proprietary/houdini/etc/init/*),\
	$(eval PRODUCT_COPY_FILES += $(f):$(PRODUCT_OUT)/system/vendor/etc/init/$(notdir $f)))
else
    $(call inherit-product, vendor/google/chromeos-x86/target/houdini.mk)
    $(call inherit-product, vendor/google/chromeos-x86/target/native_bridge_arm_on_x86.mk)
endif

