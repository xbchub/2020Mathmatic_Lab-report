%��Ӳ��ʵ��
function [m,p]=Coins(n,k)%���庯��Coins,�������nΪʵ�鳡��,kÿ������
    m=0;%�����k��������ǡ�õõ�2�����泯�ϵĳ���
    rand('state',sum(100*clock));%rand'state',sum(100*clock))����ϵͳʱ�Ӳ���������
    for i=1:n
        l=0;%������泯�ϵĴ���
        for j=1:k
        	if rand>0.5%�ж��Ƿ����泯��
                l=l+1;
            end
        end
        if l==2
            m=m+1;
        end
    end
p=m/n

