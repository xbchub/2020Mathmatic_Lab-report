function [a,b,c]=white_win(x,y,n)
%x,y为白球黑球个数
a = 0;b = 0;c = 0;
for i = 1:n
    m = 1:x;  %1~x序号为白球
    m = [m,x+1:x+y];  %x+1~x+y序号为黑球
    number = x+y
    while number>0
        a_ = randi([1,length(m)],1,1);  %通过下标寻找
        if m(a_)<=x  %A摸到1~x的白球
            a = a+1;  %A胜利次数+1
            break
        else
            m(a_) = [];  %删去对应球序号
        end
        
        b_ = randi([1,length(m)],1,1);
        if m(b_)<=x  %B摸到1~x的白球
            b = b+1;  %B胜利次数+1
            break
        else
            m(b_) = [];  %删去对应球序号
        end
        
        c_ = randi([1,length(m)],1,1);
        if m(c_)<=x  %C摸到1~x的白球
            c = c+1;  %C胜利次数+1
            break
        else
            m(c_) = [];  %删去对应球序号
        end 
    end
end
a/n  %A获胜概率
b/n  %B获胜概率
c/n  %C获胜概率