%%��һ���룺
function itp2(n)
x = linspace(-5,5,n);
f = inline('1./(1+x.^2)');  %���ַ���תΪ����
y = f(x);  
xi = linspace(-5,5,101);  
yi = itp1(x',y',xi);  
plot(xi,yi,'r--', xi,f(xi));
legend('��ֵ����', 'ԭʼ����')