%%实验一代码：
x = dsolve('D2x+2*c*w*Dx+w^2*x=0','t');  %desolve函数求解

%%实验二代码：
[t,x] = ode45('odefun3',[0,4],[1,0]);  %初值为x(0)=1, x'(0)=0

%%实验三代码：
x1 = dsolve('D2x1+20*Dx1+w^2*x1=0','x1(0)=1','Dx1(0)=0','t1');  
t1 = 0:0.01:4;
%为与ode函数对比，再求解dsolve函数，采用相同特殊值c=1，w=10，x(0)=1, x'(0)=0
x1= exp(-10*t1)+10*exp(-10*t1).*t1;


subplot(2,1,1)
plot(t1,x1,'r')
title('dsolve求解(解析解)')  %画出解析解

subplot(2,1,2)
plot(t,x(:,1),'b')  %x包含x1和x2，只画x2
title('ode45求解(数值解)')  %画出数值解

%实验四代码：
c_=[0.2,0.4,0.6,0.8,1]; 
figure
ode4(c_)
title('取c为多个值的ode曲线')