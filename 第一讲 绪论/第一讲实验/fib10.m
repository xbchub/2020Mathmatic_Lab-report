M=dlmread('fib5.txt')  %����txt�ı���������
t=M(1,:)'   %��ȡ���ݣ�����ע��Ҫת��
y=M(2,:)'
p6= polyfit(t,y,6);
p3= polyfit(1./t,log(y),1);
plot(t,y,'r+',t,polyval(p6,t),t,exp(polyval(p3,1./t)))
legend('��������', '6 �׶���ʽ���', 'ָ�������')