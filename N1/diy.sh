#!/bin/bash

# 移除 SNAPSHOT 标签
sed -i 's,-SNAPSHOT,,g' include/version.mk
sed -i 's,-SNAPSHOT,,g' package/base-files/image-config.in

# Add packages
git clone https://github.com/ophub/luci-app-amlogic --depth=1 clone/amlogic
git clone https://github.com/xiaorouji/openwrt-passwall --depth=1 clone/passwall

# Update packages
rm -rf feeds/luci/applications/luci-app-passwall
cp -rf clone/amlogic/luci-app-amlogic clone/passwall/luci-app-passwall feeds/luci/applications/

### 额外的 LuCI 应用和依赖 ###
mkdir -p package/new

# 添加翻译
cp -rf ../openwrt-apps/addition-trans-zh ./package/new/addition-trans-zh

# 更换 golang 版本
rm -rf ./feeds/packages/lang/golang
cp -rf ../openwrt_pkg_ma/lang/golang ./feeds/packages/lang/golang

# Nikki
cp -rf ../openwrt-apps/OpenWrt-nikki ./package/new/luci-app-nikki

# Clean packages
rm -rf clone
