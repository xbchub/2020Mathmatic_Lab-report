M=dlmread('fib5.txt')  %����txt�ı���������
t=M(1,:)'   %��ȡ���ݣ�����ע��Ҫת��
y=M(2,:)'
p3= polyfit(1./t,log(y),1);
plot(t,y,'r+',t,exp(polyval(p3,1./t)));
R3 = dot(y- exp(polyval(p3,1./t)),y- exp(polyval(p3,1./t)))
legend('��������', 'ָ�������')