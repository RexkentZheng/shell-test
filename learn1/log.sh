#!/bin/bash  
none='\e[0m' 
red='\e[91m'  
Logfile_path='/data/wwwlogs/dzvpn-kvm.cf_nginx.log' 
echo "${Logfile_path}"
Check_http_status() {
   Http_status_codes=(`cat $Logfile_path|grep -ioE "HTTP\/1\.[1|2]\"[[:blank:]][0-9]{3}"|awk -F"[ ]+" '{
     if($2>100&&$2<200){
         i1++
     }else if ($2>=200&&$2<300){
         i2++
     }else if ($2>=300&&$2<400){
         i3++
     }else if ($2>=400&&$5<500){
         i4++
     }else if ($2>=500){
         i5++
     }
     }END{
         print i1?i:0,i2?i2:0,i3?i3:0,i4?i4:0,i5?i5:0,i1+i2+i3+i4+i5
     }'
  `)
  echo ${Http_status_codes[2]}
  echo "${Http_status_codes}"
}
Check_http_status

