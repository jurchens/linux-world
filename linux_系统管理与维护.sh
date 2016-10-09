＊＊＊＊＊特此说明：此文件收集整理并借鉴了雪松、PF等大神的文档shell实例手册，衷心感谢以上大神的无私奉献！＊＊＊＊＊
一.系统
1.查找命令
   a. which                           #查看执行的命令所在的位置，通常需要查找命令需要在环境变量里，例如/bin/sbin,查询速度较快
   b. whereis                         # 通常用与查找已安装的程序或命令以及文件手册等，查询速度较快
   c. locate                          # 类似模糊查询，含有相关字符的都会罗列出来，查询速度略慢
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
     history                          # 历史默认条数1000
     .bash_history                    # 查看更多的历史纪录，历史纪录文件
     history -c                       # 清除历史纪录
     tail -f /var/log/messages        # 查看后10行系统日志
     tail -f /var/log/secure          # 查看ssh相关日志
8.用户和组管理
    users                             # 查看所有登陆用户
    useradd                           # 新建用户
    groupadd                          # 新建组
    useradd -g group user             # 新建用户并加入组
    gpasswd -a user group             # 将用户添加到制定的组
    gpasswd -d user group             # 将用户从组中删除 
    useradd -g www -M -s /sbin/nologin www  # 指定组并不允许登陆的用户，但可以使用服务
    useradd -g www -M -s /sbin/false   www  # 指定组并不允许登陆的用户，false 最为严格
    usermod -l newname oldname              # 修改用户名，但是家目录名不改变
    usermod -g user group             # 修改用户所属组
    usermod -G group user             # 将用户添加到附加组
    usermod -L user                   # 锁定用户
    usermod -U user                   # 解锁用户
    passwd  -l                        # 锁定用户
    passwd  -u                        # 解锁用户         
    groups                            # 查看组
    groups user                       # 查看用户所在的组
    passwd user                       # 修改密码
    userdel -r                        # 删除用户及家目录
    chown -R user:group               # 更改用户所属
    chown -R mysql .                  # 更改所有者
    chgrp -R mysql .                  # 更改所属组
    finger                            # 查找用户显示信息
    last                              # 查看登陆过的用户信息
    lastlog                           # 用户最后登录的时间
    who /var/log/wtmp                 # 查看登陆过的用户信息
    lastlog                           # 用户最后登录时间
    lastb -a                          # 列出登录系统失败的用户信息
    su - user -c " #命令1；.."        # 切换用户执行命令
    id -u                             # 查看当前用户的uid 号
    /var/log/btmp                     # 登录失败二进制日志记录文件
9.selinux
    sestatus -v                       # 查看selinux 状态
    getenforce                        # 查看selinux 模式
    setenforce 0                      # 临时设置宽容模式，permissive
    setenforce 1                      # 临时设置force模式

10.文件管理
   touch                              # 新建一个文件，若文件存在，则修改时间，文件内容不覆盖
   touch -t file                      # 指定文件的修改时间
   ls                                 # 显示文件列表
   ls -a                              # 显示文件列表，包括隐藏文件
   ll -a                              # 以纵列表的方式显示，包括隐藏文件
   rm                                 # 删除文件，提示是否删除
   rm -f                              # 强制删除
   rm -rf                             # 递归强制删除
   enca file                          # 查看文件编码
   ln s  d                            # 建立硬链接
   ls -s s d                          # 建立软链接
   symlinks -r /  | grep '目录'       # 查看系统的软连接
   readlink -f  /data                 # 查看链接的真实目录
   head                               # 查看文件前10行
   tail                               # 查看文件后10行
   uniq                               # 删除重复的行
   uniq -c                            # 重复的行出现的次数
   wc -l                              # 统计行数
   paste a b                          # 将两个文件合并，并用tab 键隔开
   paste -d'+' a b                    # 将两个文件合并，并用+ 号隔开
   more                               # 向下分页
   less                               # 向上分页 
   wc -l                              # 查看文件行数
   cp -R /dir1 /dir2                  # 递归拷贝目录
   cp filename{,.bak}                 # 快递备份一个文件
   cp -p a b                          # 保留文件属性
   cp -f a b                          # 强制覆盖
11.sort 排序
   sort　-n                           # 按照数值的大小排序
   sort  -nr                          # 按数字倒叙
   sort　-u                           # 过滤重复行
   sort  -m a.txt c.txt               # 将两个文件内容整合到一起
12.vim
    :set nu                           # 显示行号
    $s/字符1/字符2/g                  # 全部替换
13.解压缩
   tar -zxvf   file                   # 解压
   tar -zcvf   file.gz  file          # 压缩
   tar -zxvf file   -C 目录           # 解压到指定目录
   
二. 硬件相关
1.内存
  free -m                             # 查看剩余内存
2.cpu
  cat /proc/cpuinfo |more             # 查看cpu详细信息
  cat /proc/cpuinfo |grep "physical id" |sort -u | wc -l      #查看物理cpu 个数
                                  
  
3.服务器
  dmidecode                           # 查看服务器全面信息
  dmidecode |grep "Product Name"      # 查看服务器厂商和型号
  cat /proc/scsi/scsi                 # 查看dell raid 卡信息
4.网络
  ifconfig                            # 查看所有网卡信息
  vim /etc/sysconfig/network-scripts/ifcfg-eth0                # 编辑网卡信息
  service network restart &  /etc/init.d/network restart       #重启网卡
5.硬盘
  df -Th                              # 显示硬盘容量及分区格式
  du -h directory                     # 显示目录下所有文件大小
  mount                               # 查看分区挂载情况
  mount -a                            # 使挂载生效
  mkfs.ext4 /dev/sda1                 # 格式化分区
  fdisk -l |more                      # 查看磁盘分区状态
  fdisk /dev/sda1                     # 分区
  mkfs -t ext3 /dev/md0               # 格式化分区
  lsof |grep delete                   # 查看已经被删除的文件，但进程还存活，列出相应进程kill掉，释放磁盘空间
  kill -9  pid                        # 通过lsof 已删除文件的进程，kill 掉，释放磁盘空间
  smartctl -H /dev/sda                # 检查磁盘状态
  smartctl -i /dev/sda                # 显示磁盘信息
  fsck -y /dev/sda1                   # 修复磁盘，会造成磁盘数据部分丢失的概率
  hdparm -Tt /dev/md0                 # 测试磁盘读写速度
  mount -t ngfs-3g /dev/sdb /data/mnt # 挂载ntfs 格式的磁盘
  mount -t iso9660 /dev/dvd /mnt      # 挂载光盘
  mount -o loop /data/*.iso /mnt      # 挂载镜像文件
  mount -a                            # 使挂载生效，一般用于fstab 修改后
  umount /data/mnt                    # 卸载
  dd if=/dev/zero of=文件名 bs=1M count=1000  # 创建一个1g 的文件
  dd if=/dev/zero of=test   bs=2M seek 10000  # 创建一个2T 的文件，不写入磁盘速度和内存相当
  新硬盘挂载顺序：
      1.使用fdisk -l |more  找到新硬盘，比如/dev/sdb
      2.分区：fdisk /dev/sdb 初始化，选择n,进行分区，例如只分一个分区/dev/sdb1
      3.格式化： mkfs.ext4 /dev/sdb1
      4.挂载： mount /dev/sdb1  /mnt/data
      5.修改开机自动挂载
        vim /etc/fstab
        添加如下行
        /dev/sdb1                   /mnt/data    ext4  defaults 0 0
      6.生效挂载：生效挂载

三.软件

1.软件安装   
   rpm -qa | grep 软件包或服务        # 查看系统是否安装相关软件或服务
   rpm -ivh                           # rpm 安装
   rpm -e                             # rpm 卸载
   rpm -e  --nodeps                   # rpm 强制卸载
   yum list                           # 查找所有列表
   yum install -y                     # yum 自动安装
   yum -y update                      # 升级制定软件包
   yum search                         # 搜索软件包
2.配置yum源
  例如：配置163 yum 源
  1.访问 mirrors.163.com
  2.以 centos 为例，点开右侧的centos 使用帮助
  3.选择相应的版本repo下载
  4.备份原有的yum 源： mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
  5.生成缓存： yum clean all   yum makecache
  6.完成 
  
  
   
四.系统监控
   top                                # 查看当前系统运行状态，包括cpu负载 ,mem使用，及进程等，如果cpu是多核，按1具体核数及显示情况
   uptime                             # 查看系统运行时间 
   sar                                # 查看cpu 状态
   vmstat 1 9                         # 打印系统性能9次/s
   ps aux |grep -v USER |sort -nk +4 | tail                    #显示消耗内存最多的10个进程，按内存使用排序
   iftop                              # 监控网络流量输入输出信息
    

    
      

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
    git push origin 分支名            # 推送到github远程仓库
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
    git merge --no-ff -m "description" dev                    # 禁用fast forward ,改为普通模式的合并，目的是可以查看分支合并历史
    git stash                                                 # 保存工作现场
    git stash pop                                             # 回到工作现场
    git remote                                                # 查看远程仓库的名称
    git remote -v                                             # 查看远程仓库的详细信息
    git checkout -b dev origin/dev                            # 常见远程仓库的dev 到本地
    git branch --set-upstream dev origin/dev                  # 建立本地仓库的分支和远程仓库分支的关联
    git 解决冲突的方法就是把两个有冲突的分支的内容进行选择或合并，删除多余内容





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


SHELL 脚本实例练习
1.向/etc/passwd 目录下的用户询问，并统计用户数

#!/bin/bash
# DESC:Say hello to every user in the /etc/passwd directory, and count the number of the users
# AUTHOR: JURCHENS
# DATE:2016/10/9
PAHT=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
file=/etc/passwd  # 定义一个变量file
let num=0         # 用let 命令定义一个初始值为0的num
for i in `cat $file`    # 使用for 循环，遍历/etc/passwd 目录
do
  username=`echo "$i" | cut -f1 -d:`         # 使用cut 截取第一片段，用：做分隔符
  userid=`echo "$i" | cut -f3 -d:`           # 使用cut 截取第三片段，用：做分隔符
echo "hello ,$username,your id is $userid"
num=$[ $num + 1 ]                            # 遍历完一个用户后，加 1
done
echo the number of user is $num.

2.使用for 循环，询问/var 目录下文件，并统计文件数

#!/bin/bash
# DESC: Say hello to every file in the /var directory ,and count the num of file
# AUTHOR: JURCHENS
# DATE: 2016/10/9
PATH=/bin:/sbin:usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
cd /var
let num=0
for i in `ls /var/*`
do
echo "hello ,$i"
num=$[ $num + 1 ]
done
echo the num is $num

3.ping 某一个网段的ip 是否在线
 
 #!/bin/bash
 # DESC: Test the host is yes or no online
 # AUTHOR: JURCHENS
 # DATE : 2016/10/9
 PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~bin
 export PATH
 for i in `seq 1 254`
  do
     ping -c1 -w1 -i0.5 192.168.40.$i &>/dev/null && echo "192.168.40.$i is up" || echo "192.168.40.$i is down"
 done
