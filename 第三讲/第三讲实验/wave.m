disp('待输入值：EE电场强度，f电磁波频率，x0位置，t0时刻')  %外部输入必要的参数
u0=4*pi*1e-7;  %磁导率
e0=1e-9/(36*pi);  %电介质常数
Z0=(u0/e0)^0.5;  %波阻抗
f=1e8;  %电磁波的频率默认值
w=2*pi*f;
k=w*(u0*e0)^0.5;  %波数
EE=20;  %电场强度默认值
HH=EE/Z0;
x=0:0.1:20;  %传播方向上的采样点
mo=zeros(size(x));
Ez=EE*cos(k*x-w*t*1e-9);、、
Hy=HH*cos(k*x-w*t*1e-9);
disp('x0处t0时刻的电场强度：')
Ez0=abs(EE*cos(k*x0-w*t0*1e-9))
disp('x0处t0时刻的磁场强度：')
Hy0=abs(HH*cos(k*x0-w*t0*1e-9))
plot3(x,mo,Ez,'b');
hold on 
plot3(x,Hy,mo,'g');
plot3(x0,Hy0,Ez0,'*r')
hold off 
xlabel('传播方向')
ylabel('磁场')
zlabel('电场')
title('平面电磁波传播示意图')
legend('电场传播','磁场传播','x0处点')