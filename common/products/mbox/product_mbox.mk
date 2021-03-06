$(call inherit-product, device/amlogic/common/core_amlogic.mk)

ifeq ($(TARGET_BUILD_LIVETV),true)
#TV input HAL
PRODUCT_PACKAGES += \
    android.hardware.tv.input@1.0-impl \
    android.hardware.tv.input@1.0-service \
    vendor.amlogic.hardware.tvserver@1.0_vendor \
    tv_input.amlogic

# TV
PRODUCT_PACKAGES += \
    libtv \
    libtv_linker \
    libtvbinder \
    libtv_jni \
    tvserver \
    libtvplay \
    libvendorfont \
    libTVaudio \
    libntsc_decode \
    libtinyxml \
    libzvbi \
    droidlogic-tv \
    TvProvider \
    DroidLogicTvInput \
    DroidLogicFactoryMenu \
    libjnidtvsubtitle

# DTV
PRODUCT_PACKAGES += \
    libam_adp \
    libam_mw \
    libam_ver \
    libam_sysfs

# LiveTv
PRODUCT_PACKAGES += \
    DroidLiveTv
endif

# DLNA
ifneq ($(TARGET_BUILD_GOOGLE_ATV), true)
PRODUCT_PACKAGES += \
    imageserver \
    DLNA
endif

PRODUCT_PACKAGES += \
    remotecfg

ifneq ($(TARGET_BUILD_GOOGLE_ATV), true)
# NativeImagePlayer
PRODUCT_PACKAGES += \
    NativeImagePlayer

#MboxLauncher
PRODUCT_PACKAGES += \
    DeviceID \
    Launcher2
endif

#droid vold
PRODUCT_PACKAGES += \
    droidvold

# Camera Hal
PRODUCT_PACKAGES += \
    camera.amlogic

PRODUCT_PROPERTY_OVERRIDES += ro.hdmi.device_type=4


PRODUCT_PACKAGES += \
    OTAUpgrade

#Tvsettings
PRODUCT_PACKAGES += \
    Settings \
    DroidTvSettings


#USB PM
PRODUCT_PACKAGES += \
    usbtestpm \
    usbpower

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.app_widgets.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.app_widgets.xml \
    frameworks/native/data/etc/android.software.backup.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.backup.xml \
    frameworks/native/data/etc/android.hardware.audio.output.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.output.xml \
    frameworks/native/data/etc/android.hardware.location.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.hdmi.cec.xml \

ifeq ($(TARGET_BUILD_LIVETV),true)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.live_tv.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.live_tv.xml
endif

#copy lowmemorykiller.txt
ifeq ($(BUILD_WITH_LOWMEM_COMMON_CONFIG),true)
PRODUCT_COPY_FILES += \
	device/amlogic/common/config/lowmemorykiller_2G.txt:$(TARGET_COPY_OUT_VENDOR)/etc/lowmemorykiller_2G.txt \
	device/amlogic/common/config/lowmemorykiller.txt:$(TARGET_COPY_OUT_VENDOR)/etc/lowmemorykiller.txt \
	device/amlogic/common/config/lowmemorykiller_512M.txt:$(TARGET_COPY_OUT_VENDOR)/etc/lowmemorykiller_512M.txt
endif

#DDR LOG
PRODUCT_COPY_FILES += \
    device/amlogic/common/ddrtest.sh:$(TARGET_COPY_OUT_VENDOR)/bin/ddrtest.sh

# USB
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

#usb accessory donnot need in atv
ifneq ($(TARGET_BUILD_GOOGLE_ATV), true)
PRODUCT_COPY_FILES += \
     frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml
endif



custom_keylayouts := $(wildcard device/amlogic/common/keyboards/*.kl)
PRODUCT_COPY_FILES += $(foreach file,$(custom_keylayouts),\
    $(file):$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/$(notdir $(file)))


# bootanimation
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bootanimation.zip:system/media/bootanimation.zip

#bootvideo
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bootvideo.zip:$(TARGET_COPY_OUT_VENDOR)/etc/bootvideo.zip

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/libre_computer.mp4:$(TARGET_COPY_OUT_VENDOR)/etc/bootvideo

# default wallpaper for mbox to fix bug 106225
ifeq ($(HWC_PRIMARY_FRAMEBUFFER_HEIGHT),720)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/libre_computer_720.png:$(TARGET_COPY_OUT_VENDOR)/etc/libre_computer.png
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/libre_computer_1080.png:$(TARGET_COPY_OUT_VENDOR)/etc/libre_computer.png
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.wallpaper=vendor/etc/libre_computer.png

# Include BUILD_NUMBER if defined
VERSION_ID=$(shell find device/*/$(TARGET_PRODUCT) -name version_id.mk)
ifeq ($(VERSION_ID),)
export BUILD_NUMBER := $(shell date +%Y%m%d)
else
$(call inherit-product, $(VERSION_ID))
endif

DISPLAY_BUILD_NUMBER := true

#BOX project,set omx to video layer
PRODUCT_PROPERTY_OVERRIDES += \
        media.omx.display_mode=1

BOARD_HAVE_CEC_HIDL_SERVICE := true
