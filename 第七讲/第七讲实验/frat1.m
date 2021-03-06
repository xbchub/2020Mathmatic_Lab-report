function frat1(k) %显示迭代 k 次后的 Koch 曲线图
location = [0,0;10,0]; %存放结点坐标，每行一个点，初始值为两结点的坐标
n = 1; %存放线段的数量，初始值为 1
A = [cos(pi/3),-sin(pi/3);sin(pi/3),cos(pi/3)];  %用于计算新的结点
for a = 1:k  %实现迭代过程，计算所有的结点的坐标
    j = 0;   %以下根据线段两个结点的坐标，计算迭代后它们之间增加的三个
             %结点的坐标，并且将这些点的坐标按次序存暂时放到 r 中
    for i = 1:n  %每条边计算一次
        s1 = location(i,:);  %目前线段的起点坐标
        s2 = location(i+1,:);  %目前线段的终点坐标
        d = (s2-s1)/3;
        j = j+1; 
        r(j,:) = s1;  %原起点存入 r
        j = j+1; 
        r(j,:) = s1+d;  %新 1 点存入 r
        j = j+1; 
        r(j,:) = s1+d+d*A';  %新 2 点存入 r
        j = j+1; 
        r(j,:) = s1+2*d;  %新 3 点存入 r
    end  %原终点作为下条线段的起点，在迭代下条线段时存入 r
    n=4*n;  %全部线段迭代一次后，线段数量乘 4
    clear p  %清空 p ，注意：最后一个终点 q2 不在 r 中
	location=[r;s2];  %重新装载本次迭代后的全部结点
end
plot(location(:,1),location(:,2))  %显示各结点的连线图
axis equal  %各坐标轴同比例