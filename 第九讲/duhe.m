function dx=duhe(t,x)%������Ϊduhe�ĺ���M�ļ�
    a=1;b=2;
    s=sqrt(x(1)^2+x(2)^2);
    dx=[a-b*x(1)/s;-b*x(2)/s];%��������ʽ��ʾ������