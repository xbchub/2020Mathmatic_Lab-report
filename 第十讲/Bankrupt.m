function [m,f]=Bankrupt(a,b,p,n)%���庯��Bankrupt,�������pΪӲ�����泯�ϵĸ���,nΪģ�ⲩ���ܳ���,a,b�ֱ�ΪA,B�ı�������
    Awin=0;Bwin=0;%����ǰ���˻�ʤ������Ϊ0
    rand('state',sum(100*clock));%rand('state',sum(100*clock))����ϵͳʱ�Ӳ���������
    for i=1:n  %���Ŀ�ʼ,��n��
        A=a;B=b;%ÿ������ǰA,B��ʤ����
        while A>0 & B>0%��˫����δ�Ʋ�,�򱾳����ļ�������
            r=rand;%rand����[0,1]�����Ͼ��ȷֲ������
            if r<p
                A=A+1;B=B-1;
            else
                A=A-1;B=B+1;
            end
        end
        if A==0%�ж�A�Ƿ��Ʋ�
            Bwin=Bwin+1;%�ۼ�B��ʤ����,��A�Ʋ�
        else
            Awin=Awin+1;%�ۼ�A��ʤ����,��B�Ʋ�
        end
    end
m=Awin
f=rats(Awin/n)