#!/bin/bash

#Program Function 展示系统信息

none='\e[0m'
red='\e[91m'
green='\e[92m'

clear

echo -e "${green} 这里是操作系统的信息 ${none}"

if [[ $# -eq 0 ]]
then

#查看系统类型
  os=$(uname -o)
#查看系统名称
  os_name=$(cat /proc/version|grep -e "version")
#查看主机名
  hostname=$(hostname)
#查看类型
  architecture=$(uname -m)
#查看CUP核
  kernerrelease=$(uname -r)
#查看内网IP
  internalIp=$(hostname -I)
#查看公网IP
  externalIp=$(curl -s http://ipecho.net/plain)
#查看DNS
  nameservers=$(cat /etc/resolv.conf |grep -E "\<nameserver[ ]+"|awk '{print $NF}')
#看看有没有网
  connect=""
  ping -c 2 baidu.com &>/dev/null && connect="能联网" || connect="不能联网"
#查看当前登录用户数
  w>/tmp/who
  users=$(cat /tmp/who)
  rm -rf /tmp/who 
#输出
  echo -e "${red} 系统类型 ${none} ${os}"  
  echo -e "${red} 系统名称： ${none} ${os_name}"
  echo -e "${red} 系统主机名： ${none} ${hostname}"
  echo -e "${red} 系统架构： ${none} ${architecture}"  
  echo -e "${red} 系统CUP： ${none} ${kernerrelease}"  
  echo -e "${red} 系统内网IP： ${none} ${internalIp}"  
  echo -e "${red} 系统公网IP： ${none} ${externalIp}"  
  echo -e "${red} 系统DNS： ${none} ${nameservers}" 
  echo -e "${red} 系统有没有网： ${none} ${connect}" 
  echo -e "${red} 系统当前登录用户数： ${none}"
  echo -e "${users}"  
fi

echo -e "${green} 这里是操作系统运行状态的信息 ${none}"
#系统内存部分
#系统全部内存
  total=$(awk '/MemTotal/{total=$2}END{print total/1024}' /proc/meminfo)
  free=$(awk '/MemFree/{free=$2}END{print free/1024}' /proc/meminfo)
  cached=$(awk '/^Cached/{cached=$2}END{print cached/1024}' /proc/meminfo)
  buffers=$(awk '/Buffers/{buffers=$2}END{print buffers/1024}' /proc/meminfo)
  system_used=$(awk 'BEGIN{printf "%.2f\n",('$total'-'$free')}')
#负载
  load_average=$(top -n 1 -b|grep "load average:"|awk '{ print $12 $13 $14 }')
#磁盘信息
  disk_useage=$(df -hP|grep -vE 'Filesystem|tmpfs|shm')
#输出
  echo -e "${red} 系统全部内存 ${none} ${total}MB"
  echo -e "${red} 系统可用内容 ${none} ${free}MB $(awk 'BEGIN{printf "%.2f\n",('$free'/'$total*100')}')%"
  echo -e "${red} 系统占用内存 ${none} ${system_used}MB"
  echo -e "${red} 系统负载 ${none} ${load_average}"
  echo -e "${red} 系统磁盘信息 ${none} ${disk_useage}"

#这部分的内容就是熟悉脚本的一些基础功能，比方说基础的四则运算、浮点运算之类的内容，要echo的内容有格式需要加-e参数
#还有就是变量的赋值，变量跟=之间是没有空格的，还有一个简单的三元
#ping -c 2 baidu.com &>/dev/null && connect="能联网" || connect="不能联网"
#别问我$>的意思是啥，好像是赋值给一个变量，才可以进行判断，之后的&&和||就是?和:
#使用cat可以读取文件的信息，可以将读取之后的信息直接赋值给一个变量
#grep是一个筛选，直接加载获取的内容之后，格式貌似是这样  获取内容的语句|grep 过滤的内容  比方说下面这样
#cat /proc/version|grep -e "version"  或者  df -hP|grep -vE 'Filesystem|tmpfs|shm'
#直接接在后面就好，不需要空格