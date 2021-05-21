M=dlmread('fib5.txt')  %建立txt文本导入数据
t=M(1,:)'   %读取数据，这里注意要转置
y=M(2,:)'
p2=polyfit(t,y,2)
p4=polyfit(t,y,4)
p6=polyfit(t,y,6)
R1=dot(y-polyval(p6,t),y-polyval(p6,t))
%polyval是返回n次多项式p6在t处的值
plot(t,y,'r+',t,polyval(p2,t),t,polyval(p4,t),t,polyval(p6,t))
legend('测量数据', '2 阶拟合', '4 阶拟合', '6 阶拟合')
