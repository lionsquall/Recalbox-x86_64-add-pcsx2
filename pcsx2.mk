################################################################################
#
# pcxs2
#
################################################################################

#PCSX2_VERSION = 3kinox-64-bit-clean
PCSX2_VERSION = 1.4.x
PCSX2_SITE = $(call github,PCSX2,pcsx2,$(PCSX2_VERSION))
PCSX2_LICENCE = GPLv3
PCSX2_PLATFORM =
ifeq ($(BR2_x86_64),y)
        PCSX2_PLATFORM += i386
endif


#PCSX2_DEPENDENCIES = xserver_xorg-server libevdev ffmpeg zlib libpng lzo libusb libcurl sfml bluez5_utils libgtk2
PCSX2_DEPENDENCIES = sdl portaudio libpng zlib libaio libgtk2 xserver_xorg-server libevdev ffmpeg bluez5_utils wxwidgets 
#opengl 
## Packages add: portaudio-v190600_20161030,libaio-0.3.110, wxwidgets-v3.1.0


#option configuration
PCSX2_CONF_OPTS += -DCMAKE_BUILD_TYPE=release
PCSX2_CONF_OPTS += -DXDG_STD=TRUE
PCSX2_CONF_OPTS += -DSDL2_API=TRUE
PCSX2_CONF_OPTS += -DDISABLE_PCSX2_WRAPPER=1
PCSX2_CONF_OPTS += -DPACKAGE_MODE=FALSE
PCSX2_CONF_OPTS += -DwxWidgets_CONFIG_EXECUTABLE="$(STAGING_DIR)/usr/bin/wx-config"
PCSX2_CONF_OPTS += -DPCSX2_TARGET_ARCHITECTURES=i386
PCSX2_CONF_OPTS += -DEXTRA_PLUGINS=TRUE
#PCSX2_CONF_OPTS += -DwxUSE_UNICODE=0
#PCSX2_CONF_OPTS += -DwxUSE_UNICODE_UTF8=0
PCSX2_CONF_OPTS += -DDISABLE_ADVANCE_SIMD=ON

define PCSX2_INSTALL_TARGET_CMDS
    $(INSTALL) -m 0755 -D $(@D)/pcsx2/PCSX2 $(TARGET_DIR)/usr/PCSX/bin/PCSX2
    cp -pr $(@D)/bin/Langs      $(TARGET_DIR)/usr/PCSX2/bin
        mkdir -p $(TARGET_DIR)/usr/PCSX2/bin/plugins
    cp -pr $(@D)/plugins//.so $(@D)/plugins///*.so $(TARGET_DIR)/usr/PCSX2/bin/plugins
endef

$(eval $(cmake-package))
