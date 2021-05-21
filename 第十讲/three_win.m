function [a,b]=three_win(x,y,n)
%x,y为白球黑球个数
a = 0;b = 0;
for i = 1:n
    white = 0;
    m = zeros(1,x);  %0序号为白球
    m = [m,ones(1,y)];  %1序号为黑球
    for j=1:7
        a_ = randi(length(m),1,1);
        if m(a_) == 0
            white = white+1;  %甲捡到白球
        end
        m(a_) = [];  %将当前索引删除
    end
    if white ==3
        a = a+1;
    else
        b = b+1;
    end
end
a/n  %甲获胜概率
b/n  %乙获胜概率