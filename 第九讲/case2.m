%%实验五代码：
ode4a(0.1)
% function ode4a(cval) 
%     global c
%     c=cval; %阻尼系数
%     tspan=linspace(0,4,200);
%     [t,xt]= ode45('odefun4',tspan,[1,0]);
%     animinit('onecart1 Animation')  %初始化图像animinit函数
%     axis([-2 6 -10 10]);  %限制坐标轴大小
%     hold on 
%     u=2;
%     xy=[ 0, 0, 0, 0, u, u, u+1, u+1, u, u;
%         -1.2, 0, 1.2, 0, 0, 1.2, 1.2, -1.2, -1.2, 0];
%     x=xy(1,:);y=xy(2,:);
%     plot([-10 20],[-1.4 -1.4],'b-','LineWidth',2);
%     hndl=plot(x,y,'b-','EraseMode','XOR','LineWidth',2);  
%     %“EraseMode”属性可以实现显示新对象，擦除旧对象，而又不破坏背景图案
%     %xor 方式对象的绘制和擦除由背景颜色和屏幕颜色的异或而定。
%     %只擦除和屏幕颜色不一致的旧对象的点，只绘制和屏幕颜色不一致的新对象的点
%     set(gca,'UserData',hndl);  %绘制滑行图
%     for i=1:length(xt)
%     	u=2+5*xt(i);
%         x=[0, 0, 0, 0, u, u, u+1, u+1, u, u];
%         hndl=get(gca,'UserData');
%         set(hndl,'XData',x);  %绘制滑行图
%         pause(0.02);
%         drawnow  %刷新屏幕drawnow函数
%     end

%%实验六代码：
figure
x = dsolve('D2x+2*c*w*Dx+w^2*x=20*sin(5*t)','t')  %求解有外力的解析解

% function dx= odefun5(t,x)
%     global c; %全局变量
%     dx = zeros(2,1); %列向量，分别存入x1和x2
%     dx(1)= x(2); %第一个方程
%     dx(2)= 20*sin(5*t)-20*c*x(2)-100*x(1); %第二个方程
global c
c = 0.1
tspan = linspace(0,4,100);
[t1,x1] = ode45('odefun4',tspan,[1,0])  %无外力
[t2,x2] = ode45('odefun5',tspan,[1,0])  %有外力
plot(t1,x1(:,1),'r',t2,x2(:,1),'b')
legend('无外力图像','有外力图像')
title('有无外力的对比')