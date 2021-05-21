function itp4(n)
x= linspace(-5,5,n);  %设置n个节点
f= inline('1./(1+x.^2)');  %设置函数
Y= f(x);
xi= linspace(-5,5,101);
yi= interp1(x,Y,xi,'spline ');%MATLAB自带插值函数， 'spline'三次样条插值；
plot(xi,yi,'r--', xi,f(xi));
legend('插值数据', '原始数据')