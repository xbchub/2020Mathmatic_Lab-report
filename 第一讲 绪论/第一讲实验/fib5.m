M=dlmread('fib5.txt')  %����txt�ı���������
t=M(1,:)'   %��ȡ���ݣ�����ע��Ҫת��
y=M(2,:)'
plot(t,y,'r*')
xlabel('ʱ��');
ylabel('Ũ��');
legend('������Ũ��ɢ��ͼ');

