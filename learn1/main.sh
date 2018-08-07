#!/bin/bash

none='\e[0m'
red='\e[91m'

declare -A ssharray
i=0
numbers=''

for script_file in `ls -I "main.sh" ./`
do
  echo -e "${red} 请输入相应的命令来执行相应的脚本" ${i} '===>' ${none} ${script_file}
  ssharray[$i]=${script_file}
  numbers="${numbers} | ${i}"
  i=$((i+1))
done

while true 
do
  read -p "请输入一个正确数字 [ ${numbers} ]:" execshell
  if [[ ! ${execshell} =~ ^[0-9]+ ]];then
    exit 0
  fi
  /bin/sh ./${ssharray[$execshell]}
done