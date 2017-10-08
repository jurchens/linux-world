add new sh
＊＊＊特此说明：此文件收集整理并借鉴了雪松、PF等大神的文档shell实例手册，衷心感谢以上大神的无私奉献！＊＊＊＊＊
一.系统----
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
    e. type                           # 查看命令是否为shell内置命令
         type -p ls                   # type -p 等价于which
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
   cat                                # 查看文件
   cat -n  == nl                      # 查看并显示行号，等价于 nl   
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
14.glibc升级
   1. ll /lib64/libc.so.6             # 查看系统软连的glibc的版本
   2. rmp -qa  |grep glibc            # 查看系统默认安装的glibc 版本
   3. 升级glibc 
   4. 下载 glibc-2.14.tar.gz 
   5. tar -zxvf glibc-2.14.tar.gz
   6. cd glibc-2.14
   7. mkdir build
   8. cd build
   9. ../configure --prefix=/opt/glibc-2.14
   10.  make && make install
   11. rm -rf /lib64/libc.so.6        #删除系统原来的软链
   12.DL_PRELOAD=/opt/glibc-2.14/bin/glibc-2.14.so  ln -s /opt/glibc-2.14/bin/glibc-2.14.so /lib64/libc.so.6
   13.DL_PRELOAD=/lib64/libc-2.12.so  ln -s /lib64/libc-2.12.so /libc.so.6 # 如果更新失败，用此命令还原
   14. getconf -a |grep glibc -i      # 确认升级是否成功

q
    
   
二. 硬件相关
1.内存
  free -m                             # 查看剩余内存
2.cpu
  cat /proc/cpuinfo |more             # 查看cpu详细信息
  cat /proc/cpuinfo |grep "physical id" |sort -u | wc -l      # 查看物理cpu 个数
  cat /proc/cpuinfi |grep "cpu cores" |wc -l                  # 查看cpu 逻辑核心数                             
  
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
  
3.编译安装
   ./configure --help                 # 查看help参数 
   ./configure --prefix=/usr/local    # 配置安装路径
   make                               # 编译
   make install                       # 安装  
   make clean                         # 清除编译结果
   python file.py                     # python 程序编译
   gcc -g hello.c -o hello            # c程序编译

   
四.系统监控
   top                                # 查看当前系统运行状态，包括cpu负载 ,mem使用，及进程等，如果cpu是多核，按1具体核数及显示情况
   uptime                             # 查看系统运行时间 
   sar                                # 查看cpu 状态
   vmstat 1 9                         # 打印系统性能9次/s
   ps aux |grep -v USER |sort -nk +4 | tail                    #显示消耗内存最多的10个进程，按内存使用排序
   iftop                              # 监控网络流量输入输出信息


五.文本处理
   1.正则表达式
     
     正则表达式 11 个 特殊字符： （）[] {} ^ $ + ? . * / \
     
      ^          # 定位行首
          
      $          # 定位行尾
      
      .          # 匹配换行符意外的任意字符，但必须要匹配一个字符，空格也算一个字符，如果点位置没有字符，模式不匹配
     
      *          # 匹配歉前一字符出现0到多次， 通配符的* 表示匹配0到多个任意字符
     
      .*         # 这个组合匹配任意多个任意字符的模式，通常用在数据流中两个可能相邻或者不相邻的文本字符串之间

      +          # 扩展正则，awk 使用，重复前一字符一次或者多次，但至少要一次

      ？         # 扩展正则，重复零次或者一次，只限于此，不会匹配多次出现的字符
    
      .*?        # 通常用来做最小匹配      

      []         # 匹配一组中的任意字符，通常用于字符组

      [^]        # 匹配不在制定组内的字符
   
       \         # 转义特殊字符

       {}        # 表示区间，强调因awk 不能识别区间{} ，通常需要指定选项--re-interval 或者 --posix 来识别区间

       ()        # 用来表示聚合，例如（ab|cd|ef） 
       
        |        # 管道符，用OR 的模式，指定2个或2个以上的模式

       [[:alpha:]] # 匹配字母
       [[:alnum:]] # 匹配字符和数字
       [[:digit:]] # 匹配数字
       [[:uppter:]] # 匹配大写字母
       [[:lower:]]  # 匹配小写字母
        [[a-z]]     # 匹配小写字母
        [[A-Z]]     # 匹配大写字母
        [[a-zA-Z]]  # 匹配大小写字母
        [[:punct:]] # 匹配标点符号
       正则表达式匹配问题：
       echo "this is a line number 1" | sed -n '/ber 1/p'  #正则表达式可以匹配一个或多个空格
       echo "this is a     line number 1" |sed -n '/     /p' # 查看文本中空格的好办法

  
     2.sed 流编辑器
       -n   # 阻止自动输出，只会打印受影响的行，通常和/p 配合使用
       -i   # 直接对文档操作，会修改源文件
       -e   # 输出多行命令使用
       -f   # 通过制定文本形式，进行编辑
       -s   # 替换命令
        1）sed 的4种替换标记
          a.   数字，在第几行替换
          b.    g 表示全局替换,默认只替换第一行
          c.    p 配合-n 使用，只打印受影响的行
          d.    w file 将替换的结果写入到文件
       2）sed 替换特殊字符，例如常见的/ ,可用！代替
         例如：将/etc/passwd/ 的/bin/bash 替换成 /bin/csh
         sed 's!/bin/bash/!/bin/csh/!' /etc/passwd
       3)sed 使用地址进行行编辑，需要用到行寻址，主要有2种方式实现：
         a).指定行号，或行的数字范围
         b).文本模式匹配，过滤出某行
       4)sed 执行多条命令，除了用-e,还可以使用{} 
       5）sed 删除行
          sed 'd' file    # 如果不加寻址行的话，那么流中的文本行或被默认删除
          sed '2d' file   # 删除第二行，依次类推
          sed 'n;d' file  # 删除偶数行
          sed '1~2!d' file # 删除偶数行
          awk 'NR%2==1' file # 删除偶数行
          sed '1~2d' file    # 删除奇数行
          awk 'NR%2==0' file # 删除奇数行
       6)sed 插入行，有两种插入方式，i表示行前插入，a 表示行后插入
         sed 'i\' # 不指定行号，会在所有行的前面插入
         sed 'a\' # 不指定行号，会在所有行的后面插入
         sed '1i\this is a new line'
         sed '$a\this is a last line'
        
         sed 插入空白行实例：
          sed 'G' file    # 在每一行的行后插入空白行
          sed '{x;p;x}' file  # 在每一行的行前插入空白行
          sed '{x;p;x;G}'     # 在每一行的行前和行后插入空白行
          sed '{x;p;x;$G}' file   # 在每一行的航前插入空白行，然后在最后一行的行后再插入一个空白行
          sed '1G' file           # 在第一行后插入空白行
          sed '1{x;p;x}' file     # 在第一行钱插入空白行
          sed '/^$/d;G'  file     # 在每个非空白行后，插入空白行，/^$/d 表示先删除空白行
          sed '/^$/d;G;G;G'       # 在每个非空白行之后，插入3个空白行
          sed '/^[[:space:]]*$/d;G' # 在每个非空白行之后，插入空白行，包含由空格或制表符组成的空行
          sed '/^\s*$/d';G'         #  在每个非空白行之后，插入空白行，包含由空格或制表符组成的空行
          sed 'n;G'                 #  在偶数行后，插入一个空白行

       7)sed 修改行
          sed 'c\' # 不指定行号，会修改所有行
       8）sed 转换命令，y 转换命令是唯一一个可以处理单个字符的sed编辑命令，格式：
           [address]y/inchars/outchars
          sed ’y/123/789‘ file
       9) sed 打印行
          1.打印行，用小写p 打印行
            echo "hello" |sed 'p'
          2.打印行号：用=号命令打印行号
             sed '=' data1 |sed 'N;s/\n/ /'  # 打印行号，并将行号和文本在一行显示
             sed '=' data1 |sed '/[[[:digit:]]]/{N;s/\n/ /}'
             sed '=' data1 |sed '/.*/{N;s/\n/ /}'
             awk '{print NR,$0}' file
          3.l 列出行
              sed -n '3,5l' /etc/passwd      # 列出 /etc/passwd 的3到5行
       10）sed 和文件一起工作
           1.向文本写入
            sed '2,3w test' data1 # 将data1 文件的2到3行 写入到test 文件里
           2.从文件读取数据
            sed '3r data5' data1 # 将data 5的所有数据读取出来插入到data1的第三行后面。
            sed '$r data5' data1 # 将data 5 的所有数据读取出来插入到data1的最后一行

        11）模式空间和保持空间：
            一般正常来讲，sed 读取文本，按顺序逐行将文本首先放到模式空间，也就是将该行备份，所以sed
           操作除指定 -i 外，不会修改源文件，将读取行放入模式空间后，执行sed 脚本，执行时，是每行执行完所
           有的sed 脚本命令，直至末尾，然后打印模式空间，清空模式空间读取下一行，但有时我们需要临时保存一
           些行，就里就有了保持空间的概念，其中如下命令用来模式空间和保持空间之间的的复制，追加，交换等操
           做：

           h|H(hold)  # 将模式空间复制或追加到保持空间
           g|G(get)   # 将保持空间复制或追加到模式空间
           x          # 交换模式空间和保持空间
          注： 保持空间默认是空白行
        12）多行命令
            N      # 追加下一行，创建多行组来处理,使用N 时注意一个问题，它是追加下一行到模式空间，所以它通常
                     会忽略最后一行的匹配，如果你匹配的文本恰好在最后一行，那么最后一行就不会执行sed脚本，解
                     决这种情况的方法是，先写一条单行替换的命令，然后在执行大N命令
              例如：sed '=' file |sed 'N;s/\n/ /' 
         
            D      # 删除多行中的一行，它只删除模式空间的第一行包含换行符的所有字符
           
            P      # 打印多行组中的一行，它只会打印模式空间的第一行
        13）单行命令
            n      # 读取下一行（覆盖上一行）
            ！     # 对前面要批犯的范围取反
        14) 标签函数
            ：lable  # 建立命令标记，配合b t 函数使用跳转
            b        # 分支到脚本带有标记的地方，如果分支不存在，则跳转到脚本末尾
            t        # 判断分支，从最后一行开始，与b 函数不同在于t 在执行跳转前会先检查前一个替换命令是否成功
                       ，如果成功，则执行跳转
        15) 模式替换：
           
           & ：用来替换命令中的匹配模式，不管预定义模式是什么文本，都能用& 代替
               echo "The cat is sleep in his hat " sed ’s/.at/&g‘
           sed 's/()/\1/' :替换单独的单词
           echo "The  furry cat is pretty" |sed 's/furry \(.at\)/\1/
     
      

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
 for i in `seq 1 254` # seq 列出1-254之间的数，等价于$(seq 1 254)
  do
     ping -c1 -w1 -i0.5 192.168.40.$i &>/dev/null && echo "192.168.40.$i is up" || echo "192.168.40.$i is down" # -c1 指定返回次数1次，-w1 制定deadtime or timeout 为1s, -i0.5 指定时间间隔为0.5s
 done

4.传递两个参数进行四则运算

  #!/bin/bash
  # DESC: Pass two parameters, the calculation of the four numbers of the two operations
  # AUTHOR: JURCHENS
  # DATE: 2016/10/10
  PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
  export PATH
  echo "the first number is $1"
  echo "the second number is $2"
  echo "$(($1 + $2))"
  echo "$[ $1 - $2 ]"
  echo "$[ $1 * $2 ]"
  echo "$[ $1 / $2 ]"
  

5.修改目录所有者和权限
  
  #!/bin/bash
  # DESC: change the ower and permissions for the directory
  # AUTHOR: JURCHENS
  # DATE: 2016/10/10
  
  PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
  export PATH
  mkdir -p /tmp/scripts
  cd  /tmp/scripts
  cp /etc/pam.d ./test
  chown -R RedHat ./test
  chmod o=--- ./test


  # ./test.sh 2 3


6.列出目录和文件
 
  #!/bin/bash
  # DESC: list the file and directory
  # AUTHOR: JURCHENS
  # DATE: 2016/10/10
  PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
  export PATH
  date +%Y-%m-%d-%X
  mkdir -p /tmp/lstest
  cd /tmp/lstest
  mkdir a1d b56e 6test
  touch xy x3y 732
  ls [ax6]*
  ls [[:alpha:]][[:digit:]]*

7.添加多个用户，若用户存在，不添加

  #!/bin/bash
  # DESC: Add 10 uers ,if user is exist ,not add it
  # AUTHOR: JURCHENS
  # DATE: 2016/10/10
   PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
   export PATH
   for i in `seq 1 10`
   do
    cut -f1 -d: /etc/passwd |grep "user$i" 2>>/tmp/err || useradd user$i

8.显示当前日期
  
   #!/bin/bash
   # DESC: display the current date
   # AUTHOR: JURCHENS
   # DATE: 2016/10/11
   PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/lcoal/bin:/usr/local/sbin:~/bin
   export PATH
   echo "the current is `date +%Y-%m-%d-%X`"

9.显示文件名和位置参数
   #!/bin/bash
   # DESC: Display the file name ,and display the location parameter
   # AUTHOR: JURCHENS
   # DATE: 2016/10/11
   PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
   export PATH
   ehco "the first pragram is $0"
   echo " the parameter is $1 $2 $3"
   echo "the pragram is exit"
   # ./tesh.sh a b c
		

10.判断并显示位置参数
   #!/bin/bash
   # DESC: 	determine and dispaly the parameters
   # AUTHOR: JURCHENS
   # DATE: 2016/10/11
   PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
   export PATH
   
   if [ -d $1 ]
   then
     echo "the directory $1 is existed"
   else
     echo "the directory $1 is not existed, and create it"
     mkdir -p /tmp/$1
     echo "the create directory is $1"
   fi
    # ./para.sh a

11.创建50 个目录，并且并每个目录赋予相关权限
   
   #!/bin/bash
   # DESC: create 50 directories ,and give permissions.
   # AUTHOR: JURCHENS
   # DATE: 2016/10/11
   PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
   export PATH
   i=1                            #定义变量i
   while [ $i -le 50 ]            #用while循环用户数
   do
    if [ -d /usrdata ]            # 判断/usrdata 目录是否存在
     then
       mkdir -p /usrdata/user$i   # 无论存在与否，都建子目录
    else
       mkdir /usrdata             # 不存在就新建目录 
       mkdir -p /usrdata/user$1   # 不存在就新建子目录
     fi
    chmod 755 /usrdata/user$1     # 赋予权限
    i=$(($i+1))                   # 变量循环  
    done

12.使用vim 创建计划任务
   #!/bin/bash
   # DESC: use vim editor create crontab 
   # AUTHOR: JURCHENS
   # DATE: 2016/10/11
   PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
   export PATH
   */5 * * * *  /usr/sbin/ntpdate time.nist.gov >/dev/null 2>&1
   #crontab test.cron  # 执行，提及到达守护进程

13.验证用户合法性
   
   #!/bin/bash
   # DESC: determition the valid of the user
   # AUTHOR: JURCHENS
   # DATE: 2016/10/11
   PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/bin:~/bin
   export PATH
   isvalidAlphaNum()
   {
    compressed="$(echo $1 |sed 's/[^[:alnum:]]//g')"
    if [$compressed != $1 ]
    then
        return 1
    else
        return 0
    fi
   }
    echo -n "Enter input:"
    read input
    if ! isvalidAlphaNum "&input"
    then
        echo "invalid"
        exit=1
    else
       echo "valid"
     fi
     exit=0

14.判断文件路径
   #!/bin/bash
# DESC: determition the url of file
# AUTHOR: JURCHENS
# DATE: 2016/10/11
  PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
  export PATH
  if [ -d /data/test/aaa ]
  then
      echo "find the aaa"
        if [ -d /data/test/bbb ]
        then 
           echo "find the bbb"
        else
           echo "no find the bbb"
        fi

  else
      echo "no find the aaa"
  fi

15.统计$PATH 文件数
   #!/bin/bash
   # DESC: Count the number of the files from the directory
   # AUTHOR: JURCHENS
   # DATE: 2016/10/18
    
   PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
   export PATH
   mypath=`echo $PATH|sed 's/:/ /g'`
   
   for directory in $mypath
   do
     check=`ls $directory`
      for term in $check
      do
        count=$[ $count + 1 ]
       done
      echo "directory - count"
   done
   
16.验证电话号码


 #!/bin/bash
 # DESC: vertify the phone number
 # AUTHOR: JURCHENS
 # DATE: 2016/10/18
 PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/bin:/usr/local/sbin:~/bin
 export PATH
 awk --re-interval '/\(?[2-9][0-9]{2}\)?(| |-|\.)[0-9]{3}( |-|\.)[0=9]{4}/'
 # ehco　＂345-456-4567＂ | ./phone.sh  

17.验证域名
  #!/bin/bash
  # DESC: vertify the domian number
  # AUTHOR: JURCHENS
  # DATE: 2016/10/18
  awk --re-interval '/^([[[:alnum:]]_\-\.\+]+)@([[[:alnum:]]_\-\.]+)\.([[:alpha:]]{2,5})/{print $0}'/'
 

18.使用curl 下载网站上的图片

  #!/bin/bash
if [ $# -ne 3 ];then
  echo "Usage: $0 URL -d DIRECTORY"
  exit -1
fi


for i in {1..4}
do
   case $1 in
   -d)
      shift; directory=$1; shift
    ;;

   *)
      url=${url:-$1};shift
    ;;
   esac
done

mkdir -p $directory
baseurl=$(echo $url | egrep -o "https?://[a-z.]+")


curl -s $url | egrep -o "<img src=[^>]*>" |sed 's/<img src=\"\([^"]*\).*/\1/g' > /tmp/$$.list
sed -i "s|^/|$baseurl/|" /tmp/$$.list  #通过正则获取图片的url

cd $directory

while read filename                # while 循环
do
  curl -s -O "$filename" --silent  #  curl -O 下载并写入文件
done < /tmp/$$.list                # 从 list 标准输入读取url

testlllllllfsadfsadfsadfas 
