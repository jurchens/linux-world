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
         find / -siza file            # 按文件大小查找 
2.进程管理
    ps -efa                           # 查看所有进程
    kill -9 PID                       # 强制终止某个进程
    killall http*                     # 杀掉http所有进程的服务，有一定的危险性
    ctrl + z                          # 将前台运行的程序放到后台运行
    jobs                              # 查看后台运行的程序
 


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
