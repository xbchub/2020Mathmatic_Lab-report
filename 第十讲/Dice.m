%%单颗骰子实验
function [m,p]=Dice(n)%定义函数Dice,输入参数n为实验场数
    m=0;%存放至少出现一个6点的场数
    rand('state',sum(100*clock));%rand('state',sum(100*clock))依据系统时钟产生种子数
    for i=1:n
        out=[];
        out = randi([1,6],1,4);%randint函数产生[1,6]之间的4个随机整数,模拟连掷一颗骰子四次
        if any(out==6)%判断是否至少出现一个6点
            m=m+1;
        end
    end
    p=rats(m/n)
