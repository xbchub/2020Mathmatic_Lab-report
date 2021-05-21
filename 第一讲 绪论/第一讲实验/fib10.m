M=dlmread('fib5.txt')  %建立txt文本导入数据
t=M(1,:)'   %读取数据，这里注意要转置
y=M(2,:)'
p6= polyfit(t,y,6);
p3= polyfit(1./t,log(y),1);
plot(t,y,'r+',t,polyval(p6,t),t,exp(polyval(p3,1./t)))
legend('测量数据', '6 阶多项式拟合', '指数型拟合')