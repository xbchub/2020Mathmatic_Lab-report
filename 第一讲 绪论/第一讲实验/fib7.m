M=dlmread('fib5.txt')  %����txt�ı���������
t=M(1,:)'   %��ȡ���ݣ�����ע��Ҫת��
y=M(2,:)'
p1=polyfit(1./t,1./y,1);
plot(t,y,'r+',t,1./polyval(p1,1./t))  
%ע��polyval���Ա�������1./t��polyfit��Ӧ�ϣ�������ҲҪ����
R2 = dot(y-1./polyval(p1,1./t),y-1./polyval(p1,1./t))
legend('��������', '˫�������')