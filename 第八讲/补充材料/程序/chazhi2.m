% 按照表1输入原始数据
clear all
x=[0:0.2:5, 4.8:-0.2:0];
y=[5 4.71 4.31 3.68 3.05 2.5 2.05 1.69 1.4 1.18 1 0.86 0.74 0.64 0.57 0.5 ...
        0.44 0.4 0.36 0.32 0.29 0.26 0.24 0.2 0.15 0 -1.4 -1.96 -2.37 -2.71 ...
        -3 -3.25 -3.47 -3.67 -3.84 -4 -4.14 -4.27 -4.39 -4.49 -4.58 -4.66 ...
        -4.74 -4.8 -4.85 -4.9 -4.94 -4.96 -4.98 -4.99 -5]; 

% 逆时针转90度，节点（x, y）变为（u, v）
v0=x; u0=-y; 
% 按0.05的间隔在u方向产生插值点
u=-5:0.05:5;  
 % 在v方向计算分段线性插值
v1=interp1(u0,v0,u); 
% 在v方向计算三次样条插值
v2=spline(u0,v0,u);  
% 在（x, y）坐标系输出结果
[v1'  v2'  -u']  

subplot(1,3,1),plot(x,y),axis([0 5 -5 5]) 
gtext('原轮廓线','FontSize',12)
subplot(1,3,2),plot(v1,-u),axis([0 5 -5 5])      
gtext('分段线性插值','FontSize',12)
subplot(1,3,3),plot(v2,-u),axis([0 5 -5 5])     

gtext('三次样条插值','FontSize',12)
