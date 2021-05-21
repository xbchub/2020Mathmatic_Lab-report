function itp2(n)
x= linspace(-5,5,n);
f= inline('1./(1+x.^2)');
Y= f(x);
xi= linspace(-5,5,101);
yi= interp1(x,Y,xi,'linear');
plot(xi,yi,'r--', xi,f(xi));
legend('插值数据', '原始数据')