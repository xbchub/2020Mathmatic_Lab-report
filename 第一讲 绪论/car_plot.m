% 实验1例1:汽车刹车距离
M=dlmread('car_data.txt','\t');%读入数据
v=M(1,:)'; v=v*1000/3600;     d=M(2,:)';
plot(v,d,'bo'); %画散点图（数据处理与观察实验）    
%axis([20,140,0,200]);
mdl=@(k,v)(k(1)*v+k(2)*v.^2);%建立模型函数（建模分析与实验）
%pause  
hold on;
k0=[1,1]';
k=nlinfit(v,d,mdl,k0)%非线性拟合求参数（数据拟合实验）
vi=5:1:40;%米/每秒
di=feval(mdl,k,vi)%对所得模型求值（模型应用实验）
plot(vi,di,'g-')%画图





