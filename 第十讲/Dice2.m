%掷骰子实验
function [m,p]=Dice2(n,k)%定义函数Dice2,输入参数n为实验场数,k每场局数
    m=0;%存放在k次抛掷中恰好得到4次2点的场数
    rand('state',sum(100*clock));%rand('state',sum(100*clock))依据系统时钟产生种子数
    for i=1:n
        l=0;%存放出现2点的次数
        for j=l:k
            r=round(5*rand)+1;%模拟抛掷骰子出现点数
            if r==2%判断是否出现2点
                l=l+1;
            end
        end
        if 1==4
            m=m+1;
        end
    end
p = m/n