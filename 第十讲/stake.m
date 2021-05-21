function [Awin,Bwin,p]=stake(s1,s2,s,n)  %定义函数stake,输入参数s1,s2分别为继续博弈前A,B获胜局数,s为判赢局数,即谁先赢s局则赢得本场博弈,n为博弈总场数
Awin=0;Bwin=0;  %继续博弈时两人获胜场数均为0
rand('state',sum(100*clock));  %rand('state',sum(100*clock))依据系统时钟产生种子数
for i=1:n%博弈开始,共n场
    A=s1;B=s2;%  每场博弈前A,B获胜局数
    while A<s & B<s  %若双方获胜局数都未达到s,则本场博弈继续进行
        r=round(rand);%rand产生[0,1]区间上均匀分布随机数,round为四舍五入取整,两条指令复合产生1或0模拟博弈结果,1表示A胜一局,0表示B胜一局
        if r==1
            A=A+1;
        else
            B=B+1;
        end
    end
    if A==s
        Awin=Awin+1;%累计A获胜场数
    else
        Bwin=Bwin+1;%累计B获胜场数
    end
end
p = rats(Awin/Bwin)  %小数化为有理数