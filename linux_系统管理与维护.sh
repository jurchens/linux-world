特说明：此文件收集整理并借鉴了雪松、PF等大神的文档，shell实例手册，感谢以上大神！
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
         find / -size file            # 按文件大小查找 
2.进程管理
    ps -efa                           # 查看所有进程
    ps -aux                           # 查看所有进程
    netstat -anlp |grep port          # 查看制定端口
    kill -9 PID                       # 强制终止某个进程
    killall http*                     # 杀掉http所有进程的服务，有一定的危险性
    ctrl + z                          # 将前台运行的程序放到后台运行
    jobs                              # 查看后台运行的程序
    fg job工作号                      # 将后台移到前台
    bg job工作号                      # 启动后台暂停进程
    pstree                            # 查看进程树
    lsof file                         # 查看制定程序的所有进程
    lsof -i:20145                     # 查看制定端口的进程
    renice +1 180                     # 增加进程优先级

    
3.清空屏幕               
    clear                             # 清空屏幕
    reset                             # 初始化屏幕
4.随机密码和加密
    mkpasswd                          # 随机生成密码
    yum install expect                # 安装expect
    mkpasswd -l                       # 密码长度，默认9
    mkpasswd -d                       # 数字个数，默认2
    mkpasswd -c                       # 小写字母，默认2
    mkpasswd -C                       # 大写字母，默认2
    mkpasswd -s                       # 特殊字符，默认1
5. md5 加密
    echo -n abcde | md5sum            # 字符串abcde 用md5加密
6.时间和日期
    cal                               # 查看日历
    date                              # 查看日期和时间
    date -s yyyymmdd                  # 设定日期
    date -s hh:mm:ss                  # 设定时间
    date -d "7 days ago" +%Y%m%d      # 7天前的日期
    date -d "5 minute ago" +%H:%M     # 5分钟前的时间
    date -d "1 month ago" +%Y%m%d     # 1个月前的时间
    date +%Y-%m-%d_%T                 # 时间戳
7.日志管理
    history                           # 历史默认条数1000
    .bash_history                     # 查看更多的历史纪录，历史纪录文件
     history -c                       # 清除历史纪录
8.用户管理
    last                              # 查看登陆过的用户信息
    who /var/log/wtmp                 # 查看登陆过的用户信息
    lastlog                           # 用户最后登录时间
    lastb -a                          # 列出登录系统失败的用户信息
    /var/log/btmp                     # 登录失败二进制日志记录文件
   tail -f /var/log/messages          # 查看后10行系统日志
   tail -f /var/log/secure            # 查看ssh相关日志    
    
      

git管理
    sudo apt-get install git          # 安装git
    sudo yum install git-all git      # fedora or centos 安装git
    git status                        # 时时查看当前仓库的状态
    git diff                          # 查看修改的内容
    git log                           # 查看日志
    git reset --hard HEAD^            # 版本回退 
    git reset --hard (commit id)      # 版本回退，找到相应的commit id,回退
    git reflog                        # 记录每一次命令，通常用于查找commit id
    git add file                      # 增加file 到暂存区
    git commit file                   # 提交更改，把暂存区的文件提交到分支
    git push origin 分支名           # 推送到github远程仓库
    git checkout --file               # 把文件在工作区的更改全部撤回
    场景1：当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令git checkout -- file。

    场景2：当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令git reset   HEAD file，就回到了场景1，第二步按场景1           操作。

    场景3：已经提交了不合适的修改到版本库时，想要撤销本次提交，参考版本回退一节，不过前提是没有推送到远程库。 
    git rm file                                               # 从版本库中删除文件
    ssh-keygen -t rsa -C "jurchens_1987@163.com"              # 创建密钥用于远程登录，把id_rsa.pub拷到远程仓     库  
    git clone git@github.com:jurchens/linuxworld              # clone 远程仓库到本地
    git checkout -b dev =(git branch dev&git checkout dev)    # 创建分支并切换到分支
    git branch  dev                                           # 查看分支
    git checkout dev                                          # 切换分支
    git merge 分支名                                          # 合并分支
    git branch -d dev                                         # 删除分支
    git branch -D dev                                         # 强制删除分支
    git 解决冲突的方法就是把两个有冲突的分支的内容进行选择或合并，删除多余内容
    git merge --no-ff -m "description" dev                    # 禁用fast forward ,改为普通模式的合并，目的是可以查看分支合并历史
    git stash                                                 # 保存工作现场
    git stash pop                                             # 回到工作现场
    git remote                                                # 查看远程仓库的名称
    git remote -v                                             # 查看远程仓库的详细信息
    git checkout -b dev origin/dev                            # 常见远程仓库的dev 到本地
    git branch --set-upstream dev origin/dev                  # 建立本地仓库的分支和远程仓库分支的关联






函数：
 函数输出浮点值实例：
 #!/bin/bash
 function db()
{
  read -p "Enter a value: " value
  sum=`echo "scale=2;$value * 2" |bc`
  echo $sum
}
   result=`db`
echo "this result is $result"

  
}
注：因bash 只支持整数型运算，如果要进行字符串和浮点型运算，需要用系统的bc计算器
