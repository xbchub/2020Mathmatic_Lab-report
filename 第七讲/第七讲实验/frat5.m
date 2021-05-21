function frat5(res,iter,xc,yc,xoom)
%Mandelbrot
% res 是目标分辨率，iter 是循环次数，
%（xc,yc）是图像中心，xoom 是放大倍数
x0=xc-2/xoom;
x1=xc+2/xoom;
y0=yc-2/xoom;
y1=yc+2/xoom;
x=linspace(x0,x1,res); 
y=linspace(y0,y1,res); 
[xx,yy]=meshgrid(x,y); 
z=xx+yy*1i;
C=z;
N=zeros(res,res); %初始化N，最终根据N，对各点进行染色
tic	% 显示 tic 和 toc 间的程序运行时间
for k=1:iter
    z=z.^2+C;	%对空间上每点都进行迭代
    N(abs(z)>4)=k; %逃逸半径为 4，逃逸时间 k,未逃逸为 0 
    z(abs(z)>4)=0;
    C(abs(z)>4)=0;
end
imshow(N,[]);
toc