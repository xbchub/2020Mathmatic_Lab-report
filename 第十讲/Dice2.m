%������ʵ��
function [m,p]=Dice2(n,k)%���庯��Dice2,�������nΪʵ�鳡��,kÿ������
    m=0;%�����k��������ǡ�õõ�4��2��ĳ���
    rand('state',sum(100*clock));%rand('state',sum(100*clock))����ϵͳʱ�Ӳ���������
    for i=1:n
        l=0;%��ų���2��Ĵ���
        for j=l:k
            r=round(5*rand)+1;%ģ���������ӳ��ֵ���
            if r==2%�ж��Ƿ����2��
                l=l+1;
            end
        end
        if 1==4
            m=m+1;
        end
    end
p = m/n