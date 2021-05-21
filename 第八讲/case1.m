clc
clear all
%水塔问题求解代码：
%%求解流速图
t = [0,0.921,1.843,2.949,3.871,4.978,5.900,7.006,7.928,10.954,12.032];  %分批存放时间数据
t = [t,12.954,13.875,14.982,15.903,16.826,17.931,19.037,19.959,23.880,24.968];

height = [9.677,9.479,9.308,9.125,8.982,8.814,8.686,8.525,8.388,10.820,10.5];  %分批存放高度数据
height = [height,10.21,9.936,9.653,9.409,9.18,8.921,8.662,8.433,10.591,10.354,10.180];
%求解流速矩阵
size_ = length(t)  %输出字符数
for i = 1:size_-1
    v(1,i) = pi*8.7*8.7*(height(1,i)-height(1,i+1))/(t(1,i+1)-t(1,i));
end
x = find(v<0);  %找到并删除流速为负值点（即加水）
v(x) = [];
v  %输出流速矩阵
t_ = t; t_(size_)=[];
t_(x) = [];  %保持与v同类型
scatter(t_,v)
legend('出水流速散点图')

%%拉格朗日插值
ti= linspace(0,24.968,200);  %0-24.968中取若干节点
vi= itp1(t_',v',ti);
plot(t_,v,'r+', ti,vi);
legend('原始数据','插值数据') 

%%分段线性插值
ti= linspace(0,24.968,200);  %0-24.968中取若干节点
vi= interp1(t_,v,ti,'linear');  %调用分段线性插值
plot(t_,v,'r+', ti,vi);
legend('原始数据','插值数据') 

%%三次样条插值
ti= linspace(0,24.968,200);  %0-24.968中取若干节点
vi= interp1(t_,v,ti,'spline');  %%调用三次样条插值
plot(t_,v,'r+', ti,vi);
legend('原始数据','插值数据') 

%%三次埃尔米特插值（拓展）
ti= linspace(0,24.968,200);  %0-24.968中取若干节点
vi= interp1(t_,v,ti,'pchip');  %%调用三次埃尔米特插值
plot(t_,v,'r+', ti,vi);
legend('原始数据','插值数据') 

%%多项式拟合
p3= polyfit(t_,v,3);
p5= polyfit(t_,v,5);
p6= polyfit(t_,v,6);
ti= linspace(0,24.968,200); 
plot(t_,v,'r+',ti,polyval(p3,ti),ti,polyval(p5,ti),ti,polyval(p6,ti))
legend('测量数据', '3 阶拟合', '5 阶拟合', '6 阶拟合') 

%%检验实际值和插值
%第一段检验：
ti = linspace(0,8.967,100); 
% pp = pchip(t_,v)   %这两行可以代替下面一行，pp用于记录插值函数
% vi = ppval(pp,ti)  %ppval用于计算分享多项式，即ti在pp下的值
vi = interp1(t_,v,ti,'pchip')
S1(1,1) = trapz(ti,vi)  %计算三次埃尔米特插值下的积分

vi = polyval(p6,ti);  
S1(2,1) = trapz(ti,vi)  %计算多项式拟合下的积分

vi = interp1(t_,v,ti,'spline')
S1(3,1) = trapz(ti,vi)   %计算三次样条插值下的积分

%第二段检验：
ti = linspace(10.954, 20.839,100);
vi = interp1(t_,v,ti,'pchip')
S1(1,2) = trapz(ti,vi)  %计算三次埃尔米特插值下的积分

vi = polyval(p6,ti);  
S1(2,2) = trapz(ti,vi)  %计算多项式拟合下的积分

vi = interp1(t_,v,ti,'spline')
S1(3,2) = trapz(ti,vi)   %计算三次样条插值下的积分

%第三段检验：
ti = linspace(23.880, 25.908,50); 
vi = interp1(t_,v,ti,'pchip')
S1(1,3) = trapz(ti,vi)  %计算三次埃尔米特插值下的积分

vi= polyval(p6,ti);  
S1(2,3) = trapz(ti,vi)  %计算多项式拟合下的积分

vi = interp1(t_,v,ti,'spline')
S1(3,3) = trapz(ti,vi)   %计算三次样条插值下的积分
S1 = S1'
