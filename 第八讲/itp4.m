function itp4(n)
x= linspace(-5,5,n);  %����n���ڵ�
f= inline('1./(1+x.^2)');  %���ú���
Y= f(x);
xi= linspace(-5,5,101);
yi= interp1(x,Y,xi,'spline ');%MATLAB�Դ���ֵ������ 'spline'����������ֵ��
plot(xi,yi,'r--', xi,f(xi));
legend('��ֵ����', 'ԭʼ����')