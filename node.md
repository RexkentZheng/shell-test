## Vim的设置
增加高亮，行号，自动缩进  
```
syntax on
set number
set autoindent
set cindent
```
## Shell高亮显示
echo -e 颜色 内容  结束后内容（清空内容）  
在此可将颜色自定义为变量，之后调用变量即可，比方说：   
```
red='\e[91m'
none='\e[0m' 
echo -e "  ${red} 显示内容 ${none}"
```
这里的none是将颜色重置为黑色，还可以使用`$(tput sgr0)`来重置颜色，这样也会变成黑色
## 关联数组
用字符串作为数组的索引  
声明数组  `declare -A ass_array1`  
赋值数组  `ass_array1[index1]=shit`
