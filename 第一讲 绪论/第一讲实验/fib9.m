M=dlmread('fib5.txt')  %建立txt文本导入数据
t=M(1,:)'   %读取数据，这里注意要转置
y=M(2,:)'
p5= polyfit(log(t),y,1);
plot(t,y,'r+',t,polyval(p5,log(t)));
R4 = dot(y- polyval(p5,log(t)),y- polyval(p5,log(t)))
legend('测量数据', '对数型拟合')