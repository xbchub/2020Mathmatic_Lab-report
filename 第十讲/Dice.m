%%��������ʵ��
function [m,p]=Dice(n)%���庯��Dice,�������nΪʵ�鳡��
    m=0;%������ٳ���һ��6��ĳ���
    rand('state',sum(100*clock));%rand('state',sum(100*clock))����ϵͳʱ�Ӳ���������
    for i=1:n
        out=[];
        out = randi([1,6],1,4);%randint��������[1,6]֮���4���������,ģ������һ�������Ĵ�
        if any(out==6)%�ж��Ƿ����ٳ���һ��6��
            m=m+1;
        end
    end
    p=rats(m/n)
