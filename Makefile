#
# Copyright (C) 2012-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=tinydrcom
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_CONFIG_DEPENDS := TINYDRCOM_DEBUG

include $(INCLUDE_DIR)/package.mk

define Package/tinydrcom
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpcap
  TITLE:=Dr.COM client
  MENU:=1
endef

define Package/tinydrcom/description
  Dr.COM client v$PKG_VERSION r$PKG_RELEASE
endef

define Package/tinydrcom/config
  source "$(SOURCE)/Config.in"
endef

define Build/Prepare
  mkdir -p $(PKG_BUILD_DIR)
  $(CP) ./src/* $(PKG_BUILD_DIR)
endef

TARGET_CFLAGS += 
TARGET_CXXFLAGS += -Wno-error=format-security -DOPENWRT $(if $(CONFIG_tinydrcom_DEBUG),-Dtinydrcom_DEBUG, )

define Package/tinydrcom/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tinydrcom $(1)/usr/bin
	$(CP) -a files/* $(1)/
endef

$(eval $(call BuildPackage,tinydrcom))
