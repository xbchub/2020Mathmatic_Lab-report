%%Koch曲线产生雪花
clc
clear all
k=5  %显示等边三角形迭代k 次后的图形
A=[cos(pi/3) -sin(pi/3);sin(pi/3) cos(pi/3)];  %用于计算新的结点
B=[cos(pi/3) sin(pi/3);-sin(pi/3) cos(pi/3)];
p1=[0 0;10 0]; %存放结点坐标
p2=[0 0;5 8.66];
p3=[5 8.66;10 0];
n=1;  %存放线段的数量，初始值为 1
for s = 1:k %实现迭代过程，计算所有的结点的坐标
    j=0;
    for i = 1:n %每条边计算一次
        q1 = p1(i,:);
        q2 = p1(i+1,:);
        q3 = p2(i,:);
        q4 = p2(i+1,:);
        q5 = p3(i,:);
        q6 = p3(i+1,:);
        d1=(q2-q1)/3;d2=(q4-q3)/3;d3=(q6-q5)/3;
        j=j+1;a(j,:)=q1; b(j,:)=q3; c(j,:)=q5; %原起点存入a
        j=j+1;a(j,:)=q1+d1; b(j,:)=q3+d2; c(j,:)=q5+d3;  %新 1 点存入a
        j=j+1;a(j,:)=q1+d1+d1*B'; b(j,:)=q3+d2+d2*A'; c(j,:)=q5+d3+d3*A';  %新 2 点存入 
        j=j+1;a(j,:)=q1+2*d1; b(j,:)=q3+2*d2; c(j,:)=q5+2*d3;  %新 3 点存入
    end  %原终点作为下条线段的起点，在迭代下条线段时存入a
    n=4*n; %全部线段迭代一次后，线段数量乘 4
    clear p1 p2 p3 %清空
    p1=[a;q2]; p2=[b;q4]; p3=[c;q6]; %重新装载本次迭代后的全部结点
end
plot(p1(:,1),p1(:,2),'B');  %显示各结点的连线图
hold on
plot(p2(:,1),p2(:,2)),'Y';
plot(p3(:,1),p3(:,2)),'R';
hold off
set(findobj(gcf,'type','patch'),'edgecolor','none') %不显示边界
axis off %不要坐标轴
axis equal
