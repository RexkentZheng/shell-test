#!/bin/bash

# echo $sys_bit

# if [[ $sys_bit == "i386" || $sys_bit == "i686" ]]; then
# 	v2ray_bit="32"
# elif [[ $sys_bit == "x86_64" ]]; then
# 	v2ray_bit="64"
# else
# 	echo -e '系统有问题，不支持脚本' && exit 1
# fi

echo '准备安装一些常用工具'

echo '正在复制配置文件到指定目录'

mkdir -p /etc/v2ray/rz/v2ray
cp -rf $(pwd)/* /etc/v2ray/rz/v2ray

echo '复制成功！'

echo '开始安装v2ray'

VDIS = 64

sysArch(){
	ARCH=$(uname -m)
	if [[ "$ARCH" == "i686" ]] || [[ "$ARCH" == "i386" ]]; then
			VDIS="32"
	elif [[ "$ARCH" == *"armv7"* ]] || [[ "$ARCH" == "armv6l" ]]; then
			VDIS="arm"
	elif [[ "$ARCH" == *"armv8"* ]] || [[ "$ARCH" == "aarch64" ]]; then
			VDIS="arm64"
	elif [[ "$ARCH" == *"mips64le"* ]]; then
			VDIS="mips64le"
	elif [[ "$ARCH" == *"mips64"* ]]; then
			VDIS="mips64"
	elif [[ "$ARCH" == *"mipsle"* ]]; then
			VDIS="mipsle"
	elif [[ "$ARCH" == *"mips"* ]]; then
			VDIS="mips"
	elif [[ "$ARCH" == *"s390x"* ]]; then
			VDIS="s390x"
	fi
	return 0
}

downloadV2Ray(){
	rm -rf /tmp/v2ray
	mkdir -p /tmp/v2ray
	echo "Downloading V2Ray."
	DOWNLOAD_LINK="https://github.com/v2ray/v2ray-core/releases/download/v3.33.1/v2ray-linux-${VDIS}.zip"
	curl ${PROXY} -L -H "Cache-Control: no-cache" -o ${ZIPFILE} ${DOWNLOAD_LINK}
	if [ $? != 0 ];then
			echo "Failed to download! Please check your network or try again."
			return 3
	fi
	return 0
}

sysArch()
downloadV2Ray()

echo '安装完成啦！'