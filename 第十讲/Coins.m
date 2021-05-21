%掷硬币实验
function [m,p]=Coins(n,k)%定义函数Coins,输入参数n为实验场数,k每场局数
    m=0;%存放在k次抛掷中恰好得到2次正面朝上的场数
    rand('state',sum(100*clock));%rand'state',sum(100*clock))依据系统时钟产生种子数
    for i=1:n
        l=0;%存放正面朝上的次数
        for j=1:k
        	if rand>0.5%判断是否正面朝上
                l=l+1;
            end
        end
        if l==2
            m=m+1;
        end
    end
p=m/n

