%%双骰子实验
function [m,p]=DoubleDice(n)%定义函数DoubleDice,输入参数n为模拟场数
    m=0;%存放至少出现一对6点的场数
    rand('state',sum(100*clock));%rand'state',sum(100*clock))依据系统时钟产生种子数
    for i=l:n
        out=[];
        out=randi([1,6],2,24);%randint函数产生[1,6]之间的24个随机整数,模拟连掷一颗骰子四次
        if any(out==6)%判断是否至少出现一个6点
            m=m+1;
        end
    end
    p=rats(m/n)