% 在二维平面上绘制一对电偶极子的电场线图。
k = 8.9875e+9;  % 比例系数
e_p = 1.602e-19; % 正点电荷带电量
e_n = -e_p;  % 负点电荷带电量
e_r = 2.8e-15;  % 电荷的半径
% 指定区间： d=<x,y<=d，并生成网格数据
d = -e_r*40:e_r:e_r*40;
[x, y] = meshgrid(d);
dt = (max(d) - min(d)) / 10; % 设定两个电子间的距离
x_n = -dt / 2; y_n = 0;  % 设定负电子的坐标值
x_p = dt / 2; y_p = 0; % 设定正电子的坐标值
% 分别计算正负电荷在周围一点的电势
V1_min = k * e_n / e_r; V2_max = k * e_p / e_r;
V1 =  k * e_n ./ sqrt((x-x_n).^2 + (y-y_n).^2); % 负电荷
V2 = k * e_p ./ sqrt((x-x_p).^2 + (y-y_p).^2); % 正电荷
V1(V1==-Inf) = V1_min;  V1(V1<V1_min) = V1_min;
V2(V2==Inf)  = V2_max;  V2(V2>V2_max) = V2_max;
% 利用叠加原理计算电势
V =  V1 + V2;
[E_x, E_y] = gradient(-V);
hold on; grid on;
% 电偶极子一部分电场线从正点电荷出发， 并汇聚到负点电荷
% 绘制从正电荷发出的电场线， 这些电场线一部分汇聚到负点电荷
% 还有一部分射向无穷远
t = linspace(-pi, pi, 25);
sx = e_r * cos(t) + x_p; sy = e_r * sin(t) + y_p;
streamline(x, y, E_x, E_y, sx, sy);
% 为负电荷补充几条射向无穷远的电场线
sx = [min(d)/3*2, min(d),  min(d), min(d),  min(d)/3*2];
sy = [min(d),  min(d)/3*1, 0,  max(d)/3*1, max(d)];
streamline(x, y, E_x, E_y, sx, sy);
contour(x, y, V, linspace(min(V(:)), max(V(:)), 60));  % 绘制等势线
plot(x_n, y_n, 'ro',  x_n, y_n, 'r-', 'MarkerSize', 8); % 标出负电荷
plot(x_p, y_p, 'ro',  x_p, y_p, 'r+', 'MarkerSize', 8); % 标出正电荷
axis([min(d), max(d), min(d), max(d)]);
title('E-field of an electric dipole');
hold off;