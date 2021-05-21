%3）问代码：
function fmax = men2(n)
x = unifrnd(-1.5,1.5,1,n);  %生成(连续)均匀分布的随机数
y = unifrnd(-1.5,1.5,1,n);
f = (x.^2+2*y.^2+x.*y).*exp(-x.^2-y.^2);  %代入方程
fmax = max(f);  %求最大值
plot3(x, y, f, '.')
title('3）问图像')
grid