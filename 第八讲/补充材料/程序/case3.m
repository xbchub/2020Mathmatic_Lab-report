clc
clear all
%飞机机翼断面模拟求解代码：
%导入数据
x = [0 3 5 7 9 11 12 13 14 15];  %分批存放横坐标
y = [0 1.2 1.7 2.0 2.1 2.0 1.8 1.2 1.0 1.6];  %分批存放纵坐标
scatter(x,y,'r+')  %绘制散点图
axis equal

%%拉格朗日插值
xi= linspace(0,15,200);  %取若干节点
yi= itp1(x',y',xi);
figure  %重新建一张图
plot(x,y,'r+', xi,yi,'b');
axis equal
legend('原始数据','插值数据') 
title('拉格朗日插值')


%%分段线性插值
yi= interp1(x,y,xi,'linear');  %调用分段线性插值
figure  %重新建一张图
plot(x,y,'r+', xi,yi, 'b');
axis equal
legend('原始数据','插值数据') 
title('分段线性插值')

%%三次样条插值
yi= interp1(x,y,xi,'spline');  %调用三次样条插值
figure  %重新建一张图
plot(x,y,'r+', xi,yi, 'b');
axis equal
legend('原始数据','插值数据') 
title('三次样条插值')

%%三次埃尔米特插值（拓展）
yi= interp1(x,y,xi,'pchip');  %%调用三次埃尔米特插值
figure  %重新建一张图
plot(x,y,'r+', xi,yi, 'b');
axis equal
legend('原始数据','插值数据') 
title('三次埃尔米特插值')

%%多项式拟合
p3= polyfit(x,y,3);
p5= polyfit(x,y,5);
p6= polyfit(x,y,6);
figure
plot(x,y,'r+',xi,polyval(p3,xi),'b',xi,polyval(p5,xi),'g',xi,polyval(p6,xi),'y')
legend('测量数据', '3 阶拟合', '5 阶拟合', '6 阶拟合') 
axis equal


