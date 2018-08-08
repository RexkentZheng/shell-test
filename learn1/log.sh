#!/bin/bash  

#Program Function 查看Nginx日志信息

none='\e[0m' 
red='\e[91m'  
green='\e[92m'

allinfo=$(ps -ef |grep nginx |awk '{print $NF}')
conf_path=`echo $allinfo | cut -d" " -f 1`
Logfile_path=$(cat $conf_path|grep access_log|awk '{print $2}')
other_conf_path=$(cat $conf_path|grep include|awk '{print $2}')
x=`echo $other_conf_path | cut -d" " -f 2`
x1=${x%?}
x2=$(cat ${x1}|grep -E "access_log"|awk '{print $2}')
x3=${x2%?}
x6=$Logfile_path" ${x3}"
Check_http_status() {
  Http_status_codes=(`cat $x6|grep -ioE "HTTP\/1\.[1|2]\"[[:blank:]][0-9]{3}"|awk -F"[ ]+" '{
    if($2>100&&$2<200){
        i1++
    }else if ($2>=200&&$2<300){
        i2++
    }else if ($2>=300&&$2<400){
        i3++
    }else if ($2>=400&&$2<500){
        i4++
    }else if ($2>=500){
        i5++
    }
    }END{
        print i1?i1:0,i2?i2:0,i3?i3:0,i4?i4:0,i5?i5:0,i1+i2+i3+i4+i5
    }'
  `)
  echo -e "${green} 下面是Nginx日志中状态码的主要信息"
  echo -e "${red} 100 ${none} ${Http_status_codes[0]}"
  echo -e "${red} 200 ${none} ${Http_status_codes[1]}"
  echo -e "${red} 300 ${none} ${Http_status_codes[2]}"
  echo -e "${red} 400 ${none} ${Http_status_codes[3]}"
  echo -e "${red} 500 ${none} ${Http_status_codes[4]}"
  echo -e "${red} 总共 ${none} ${Http_status_codes[5]}"
  
}
Check_http_code() {
   Http_status_codes=(`cat $x6|grep -ioE "HTTP\/1\.[1|2]\"[[:blank:]][0-9]{3}"|awk -v total=0 -F"[ ]+" '{
      if($2!=""){
        code[$2]++;total++
      }else{
        exit
      }
    }END{
        print code[404]?code[404]:0,code[500]?code[500]:0,total?total:0
    }'
  `)
  echo -e "${green} 下面是Nginx日志中状态码的具体信息"
  echo -e "${red} 404 ${none} ${Http_status_codes[0]}"
  echo -e "${red} 500 ${none} ${Http_status_codes[1]}"
  echo -e "${red} 总共 ${none} ${Http_status_codes[2]}"
}
Check_http_status
Check_http_code

