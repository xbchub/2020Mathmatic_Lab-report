function [Awin,Bwin,p]=stake(s1,s2,s,n)  %���庯��stake,�������s1,s2�ֱ�Ϊ��������ǰA,B��ʤ����,sΪ��Ӯ����,��˭��Ӯs����Ӯ�ñ�������,nΪ�����ܳ���
Awin=0;Bwin=0;  %��������ʱ���˻�ʤ������Ϊ0
rand('state',sum(100*clock));  %rand('state',sum(100*clock))����ϵͳʱ�Ӳ���������
for i=1:n%���Ŀ�ʼ,��n��
    A=s1;B=s2;%  ÿ������ǰA,B��ʤ����
    while A<s & B<s  %��˫����ʤ������δ�ﵽs,�򱾳����ļ�������
        r=round(rand);%rand����[0,1]�����Ͼ��ȷֲ������,roundΪ��������ȡ��,����ָ��ϲ���1��0ģ�ⲩ�Ľ��,1��ʾAʤһ��,0��ʾBʤһ��
        if r==1
            A=A+1;
        else
            B=B+1;
        end
    end
    if A==s
        Awin=Awin+1;%�ۼ�A��ʤ����
    else
        Bwin=Bwin+1;%�ۼ�B��ʤ����
    end
end
p = rats(Awin/Bwin)  %С����Ϊ������