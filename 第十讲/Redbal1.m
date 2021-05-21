%摸球试验
function [m,p]=Redbal1(n,k)%定义函数Redba11,输入参数n为实验场数,k每场的摸球次数
    m=0;%存放在k次摸球中恰好取到2次红球的场数
    rand('state',sum(100*clock));%randstate',sum(100*clock))依据系统时钟产生种子数
    for i=1:n
        l=0;%存放摸到红球的次数
    	for j=1:k
            r=round(4*rand)+1;%模拟摸球过程,以1,2号代表红球,3,4,5号代表白球
            if r<3%判断是否为红球
                l=l+1;
            end
        end
        if 1==2
            m=m+1;
        end
    end
p=rats(m/n)