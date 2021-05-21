function frat2(x,y,d,n)
% x 为正方形的顶点的横坐标
% y 为正方形的顶点的纵坐标
% d 为初始正方形边长
% n 为迭代次数
for p=1:n
    location_x=[];
    location_y=[];
    
    for q=1:length(x) %每个小正方形计算一次
        x1=x(q)+[0,d/3,2*d/3,0,2*d/3,0,d/3,2*d/3];
        y1=y(q)+[0,0,0,d/3,d/3,2*d/3,2*d/3,2*d/3];
        location_x=[location_x,x1];
        location_y=[location_y,y1];
    end
d=d/3;
x=location_x; 
y=location_y;
end
hold on
for q=1:length(x) %用蓝色注满多边形区域
    fill(x(q)+[0,d,d,0,0],y(q)+[0,0,d,d,0],'g')
end
hold off
axis off
axis equal %各坐标轴同比例
set(findobj(gcf,'type','patch'),'edgecolor','none') 