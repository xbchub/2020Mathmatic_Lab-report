function [a,b]=three_win(x,y,n)
%x,yΪ����������
a = 0;b = 0;
for i = 1:n
    white = 0;
    m = zeros(1,x);  %0���Ϊ����
    m = [m,ones(1,y)];  %1���Ϊ����
    for j=1:7
        a_ = randi(length(m),1,1);
        if m(a_) == 0
            white = white+1;  %�׼񵽰���
        end
        m(a_) = [];  %����ǰ����ɾ��
    end
    if white ==3
        a = a+1;
    else
        b = b+1;
    end
end
a/n  %�׻�ʤ����
b/n  %�һ�ʤ����