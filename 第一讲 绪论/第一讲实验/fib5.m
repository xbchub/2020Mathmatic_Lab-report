M=dlmread('fib5.txt')  %建立txt文本导入数据
t=M(1,:)'   %读取数据，这里注意要转置
y=M(2,:)'
plot(t,y,'r*')
xlabel('时间');
ylabel('浓度');
legend('生成物浓度散点图');

