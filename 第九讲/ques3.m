%问题三代码
ts=0:0.1:7;
[t,x]=ode45(@duhe,ts,[0,10]);%调用ode45计算
[t,x]  %输出t,x(t),y(t)
plot(x(:,1),x(:,2));  %作y(t)的图形
grid;
title('鸭子过河模拟图')
% function dx=duhe(t,x)%建立名为duhe的函数M文件
%     a=1;b=2;
%     s=sqrt(x(1)^2+x(2)^2); %第一个方程
%     dx=[a-b*x(1)/s;-b*x(2)/s];  %第二个方程，以向量形式表示方程组