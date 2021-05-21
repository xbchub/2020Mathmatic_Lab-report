M=dlmread('fib5.txt')  %建立txt文本导入数据
t=M(1,:)'   %读取数据，这里注意要转置
y=M(2,:)'
p1=polyfit(1./t,1./y,1);
plot(t,y,'r+',t,1./polyval(p1,1./t))  
%注意polyval中自变量参数1./t与polyfit对应上，外面结果也要求倒数
R2 = dot(y-1./polyval(p1,1./t),y-1./polyval(p1,1./t))
legend('测量数据', '双曲型拟合')