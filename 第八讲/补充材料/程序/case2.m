clc
clear all
%水塔问题求解代码：
%%求解流速图
x = [7.0 10.5 13.0 17.5	34.0 40.5 44.5 48.0 56.0 61.0 68.5 76.5	80.5 91.0 96.0];  %分批存放时间数据
x = [x 101.0 104.0 106.5 111.5 118.0 123.5 136.5 142.0 146.0 150.0 157.0 158.0];

y1 = [44 45 47 50 50 38 30 30 34 36 34 41 45 46 43 37 33 28 32 65 55 54	52 50 66 66 68];  %分批存放高度数据
y2 = [44 59 70 72 93 100 110 110 110 117 118 116 118 118 121 124 121 121 121 122 116 83 81 82 86 85 68];

scatter(x,y1,'b')
hold on
scatter(x,y2,'b')
title('国土面积散点图')

%%拉格朗日插值
ti= linspace(44,158.0,400);  %取若干节点
yi1= itp1(x',y1',ti);
yi2= itp1(x',y2',ti);
plot(x,y1,'r+', ti,yi1,'r');
plot(x,y2,'r+', ti,yi2,'r');
legend('原始数据','插值数据') 

%%分段线性插值
yi1= interp1(x,y1,ti,'linear');  %调用分段线性插值
yi2= interp1(x,y2,ti,'linear');
figure
plot(x,y2,'r+', ti,yi2, 'r');
plot(x,y2,'r+', ti,yi2, 'r');
legend('原始数据','插值数据') 

%%三次样条插值
yi1= interp1(x,y1,ti,'spline');  %调用三次样条插值
yi2= interp1(x,y2,ti,'spliner');
figure
plot(x,y2,'r+', ti,yi2, 'r');
plot(x,y2,'r+', ti,yi2, 'r');
legend('原始数据','插值数据') 

%%三次埃尔米特插值（拓展）
yi1= interp1(x,y1,ti,'pchip');  %%调用三次埃尔米特插值
yi2= interp1(x,y2,ti,'pchip');
figure
plot(x,y2,'r+', ti,yi2, 'r');
plot(x,y2,'r+', ti,yi2, 'r');
legend('原始数据','插值数据') 

%%多项式拟合
p3= polyfit(x,y1,3);
p5= polyfit(x,y1,5);
p6= polyfit(x,y1,6);
figure
plot(x,y1,'r+',ti,polyval(p3,ti),'r',ti,polyval(p5,ti),'r',ti,polyval(p6,ti),'r')
legend('测量数据', '3 阶拟合', '5 阶拟合', '6 阶拟合') 

%%检验实际值和插值
%第一段检验：
% pp = pchip(t_,v)   %这两行可以代替下面一行，pp用于记录插值函数
% vi = ppval(pp,ti)  %ppval用于计算分享多项式，即ti在pp下的值
yi1 = interp1(x,y1,ti,'pchip')
S1(1,1) = trapz(ti,yi1)  %计算三次埃尔米特插值下的积分

yi1 = polyval(p6,ti);  
F1(1,1) = trapz(ti,yi1)  %计算多项式拟合下的积分

yi1 = interp1(x,y1,ti,'spline')
S2(1,1) = trapz(ti,yi1)   %计算三次样条插值下的积分

%第二段检验：
ti = linspace(10.954, 20.839,100);
yi1 = interp1(x,y1,ti,'pchip')
S1(1,2) = trapz(ti,yi1)  %计算三次埃尔米特插值下的积分

yi1 = polyval(p6,ti);  
F1(1,2) = trapz(ti,yi1)  %计算多项式拟合下的积分

yi1 = interp1(x,y1,ti,'spline')
S2(1,2) = trapz(ti,yi1)   %计算三次样条插值下的积分

%第三段检验：
ti = linspace(23.880, 25.908,50); 
yi1 = interp1(x,y1,ti,'pchip')
S1(1,3) = trapz(ti,yi1)  %计算三次埃尔米特插值下的积分

yi1= polyval(p6,ti);  
F1(1,3) = trapz(ti,yi1)  %计算多项式拟合下的积分

yi1 = interp1(x,y1,ti,'spline')
S2(1,3) = trapz(ti,yi1)   %计算三次样条插值下的积分
