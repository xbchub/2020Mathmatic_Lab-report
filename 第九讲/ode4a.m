function ode4a(cval) 
    global c
    c=cval; %阻尼系数
    tspan=linspace(0,4,200);
    [t,xt]= ode45('odefun4',tspan,[1,0]);
    animinit('onecart1 Animation')  %初始化图像animinit函数
    axis([-2 6 -10 10]);  %限制坐标轴大小
    hold on 
    u=2;
    xy=[ 0, 0, 0, 0, u, u, u+1, u+1, u, u;
        -1.2, 0, 1.2, 0, 0, 1.2, 1.2, -1.2, -1.2, 0];
    x=xy(1,:);y=xy(2,:);
    plot([-10 20],[-1.4 -1.4],'b-','LineWidth',2);
    hndl=plot(x,y,'b-','EraseMode','XOR','LineWidth',2);  
    %“EraseMode”属性可以实现显示新对象，擦除旧对象，而又不破坏背景图案
    %xor 方式对象的绘制和擦除由背景颜色和屏幕颜色的异或而定。
    %只擦除和屏幕颜色不一致的旧对象的点，只绘制和屏幕颜色不一致的新对象的点
    set(gca,'UserData',hndl);  %绘制滑行图
    for i=1:length(xt)
    	u=2+5*xt(i);
        x=[0, 0, 0, 0, u, u, u+1, u+1, u, u];
        hndl=get(gca,'UserData');
        set(hndl,'XData',x);  %绘制滑行图
        pause(0.02);
        drawnow  %刷新屏幕drawnow函数
    end