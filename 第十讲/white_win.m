function [a,b,c]=white_win(x,y,n)
%x,yΪ����������
a = 0;b = 0;c = 0;
for i = 1:n
    m = 1:x;  %1~x���Ϊ����
    m = [m,x+1:x+y];  %x+1~x+y���Ϊ����
    number = x+y
    while number>0
        a_ = randi([1,length(m)],1,1);  %ͨ���±�Ѱ��
        if m(a_)<=x  %A����1~x�İ���
            a = a+1;  %Aʤ������+1
            break
        else
            m(a_) = [];  %ɾȥ��Ӧ�����
        end
        
        b_ = randi([1,length(m)],1,1);
        if m(b_)<=x  %B����1~x�İ���
            b = b+1;  %Bʤ������+1
            break
        else
            m(b_) = [];  %ɾȥ��Ӧ�����
        end
        
        c_ = randi([1,length(m)],1,1);
        if m(c_)<=x  %C����1~x�İ���
            c = c+1;  %Cʤ������+1
            break
        else
            m(c_) = [];  %ɾȥ��Ӧ�����
        end 
    end
end
a/n  %A��ʤ����
b/n  %B��ʤ����
c/n  %C��ʤ����