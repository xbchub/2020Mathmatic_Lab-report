function frat6(c,res,iter,xc,yc,xoom)
%Julia 集
%c 为参数， res 是目标分辨率，iter 是循环次数，
%（xc,yc）是图像中心，xoom 是放大倍数
x0=xc-2/xoom;
x1=xc+2/xoom;
y0=yc-2/xoom;
y1=yc+2/xoom;
x=linspace(x0,x1,res);
y=linspace(y0,y1,res);
[xx,yy]=meshgrid(x,y);
z=xx+yy*1i; 
N=zeros(res,res);
C=c*ones(res,res);
for k=1:iter 
    z=z.^2+C;
    N(abs(z)>2)=k;
    C(abs(z)>2)=0;
    z(abs(z)>2)=0;
end
colormap jet  %colormap map将当前图窗的颜色图设置为预定义的颜色图之一，jet以一个三列数组的形式返回 Jet 颜色图
image(x,y,N);  %定坐标，确定像素颜色
axis square  %axis square 当前坐标系图形设置为方形axis equal 将横轴纵轴的定标系数设成相同值