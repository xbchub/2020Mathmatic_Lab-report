M=dlmread('fib5.txt')  %����txt�ı���������
t=M(1,:)'   %��ȡ���ݣ�����ע��Ҫת��
y=M(2,:)'
p5= polyfit(log(t),y,1);
plot(t,y,'r+',t,polyval(p5,log(t)));
R4 = dot(y- polyval(p5,log(t)),y- polyval(p5,log(t)))
legend('��������', '���������')