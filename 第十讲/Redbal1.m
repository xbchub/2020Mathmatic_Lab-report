%��������
function [m,p]=Redbal1(n,k)%���庯��Redba11,�������nΪʵ�鳡��,kÿ�����������
    m=0;%�����k��������ǡ��ȡ��2�κ���ĳ���
    rand('state',sum(100*clock));%randstate',sum(100*clock))����ϵͳʱ�Ӳ���������
    for i=1:n
        l=0;%�����������Ĵ���
    	for j=1:k
            r=round(4*rand)+1;%ģ���������,��1,2�Ŵ������,3,4,5�Ŵ������
            if r<3%�ж��Ƿ�Ϊ����
                l=l+1;
            end
        end
        if 1==2
            m=m+1;
        end
    end
p=rats(m/n)