%%Koch曲线变形
function frat4(k) %显示等边三角形迭代k 次后的图形
A=[cos(pi/3) -sin(pi/3);sin(pi/3) cos(pi/3)]; %用于计算新的结点
p=[0 0;10 0]; %存放结点坐标
n=1;
for s=1:k
    j=0;
    for i=1:n 
        q1=p(i,:);  %目前线段的起点坐标
        q2=p(i+1,:); %目前线段的终点坐标
        d=(q2-q1)/3;
        j=j+1;a(j,:)=q1; 
        j=j+1;a(j,:)=q1+d; 
        j=j+1;a(j,:)=q1+d+d*A';
        j=j+1;a(j,:)=q1+2*d; 
    end
    n=4*n;  
    clear p %清空 p 
    p=[a;q2]; %重新装载本次迭代后的全部结点
end
 
plot(p(:,1),p(:,2)) ;%显示各结点的连线图
fill(p(:,1),p(:,2),'k') %填充颜色
set(findobj(gcf,'type','patch'),'edgecolor','none')
axis off
axis equal
