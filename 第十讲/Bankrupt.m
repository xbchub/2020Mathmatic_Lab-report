function [m,f]=Bankrupt(a,b,p,n)%定义函数Bankrupt,输入参数p为硬币正面朝上的概率,n为模拟博弈总场数,a,b分别为A,B的本金数量
    Awin=0;Bwin=0;%博弈前两人获胜场数均为0
    rand('state',sum(100*clock));%rand('state',sum(100*clock))依据系统时钟产生种子数
    for i=1:n  %博弈开始,共n场
        A=a;B=b;%每场博弈前A,B获胜局数
        while A>0 & B>0%若双方均未破产,则本场博弈继续进行
            r=rand;%rand产生[0,1]区间上均匀分布随机数
            if r<p
                A=A+1;B=B-1;
            else
                A=A-1;B=B+1;
            end
        end
        if A==0%判断A是否破产
            Bwin=Bwin+1;%累计B获胜场数,即A破产
        else
            Awin=Awin+1;%累计A获胜场数,即B破产
        end
    end
m=Awin
f=rats(Awin/n)