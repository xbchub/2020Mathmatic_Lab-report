M=dlmread('fib5.txt')  %����txt�ı���������
t=M(1,:)'   %��ȡ���ݣ�����ע��Ҫת��
y=M(2,:)'
p2=polyfit(t,y,2)
p4=polyfit(t,y,4)
p6=polyfit(t,y,6)
R1=dot(y-polyval(p6,t),y-polyval(p6,t))
%polyval�Ƿ���n�ζ���ʽp6��t����ֵ
plot(t,y,'r+',t,polyval(p2,t),t,polyval(p4,t),t,polyval(p6,t))
legend('��������', '2 �����', '4 �����', '6 �����')
