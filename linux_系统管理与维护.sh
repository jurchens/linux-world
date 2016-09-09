特别说明：此文件收集整理并借鉴了雪松、PF等大神的文档，shell实例手册，感谢以上大神！
一.系统
1.查找命令
   a. which                       #查看执行的命令所在的位置，通常需要查找命令需要在环境变量里，例如/bin/sbin,查询速度较快
   b. whereis                     # 通常用与查找已安装的程序或命令以及文件手册等，查询速度较快
   c. locate                      # 类似模糊查询，含有相关字符的都会罗列出来，查询速度略慢
   d. find:（查询速度较慢）       
         find / -name file            # 按文件名查找
         find / -type file            # 按文件类型查找
         find / -mtime n              # n天前的文件，特指第n天的那一天
         find / -mtime +n             # n天以前的文件，指的是n天前
         find / -mtime -n             # n天以内的文件，指的是n天内
         find / -user username        # 按文件所有者查找 
