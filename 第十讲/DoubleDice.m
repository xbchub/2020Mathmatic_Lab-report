%%˫����ʵ��
function [m,p]=DoubleDice(n)%���庯��DoubleDice,�������nΪģ�ⳡ��
    m=0;%������ٳ���һ��6��ĳ���
    rand('state',sum(100*clock));%rand'state',sum(100*clock))����ϵͳʱ�Ӳ���������
    for i=l:n
        out=[];
        out=randi([1,6],2,24);%randint��������[1,6]֮���24���������,ģ������һ�������Ĵ�
        if any(out==6)%�ж��Ƿ����ٳ���һ��6��
            m=m+1;
        end
    end
    p=rats(m/n)