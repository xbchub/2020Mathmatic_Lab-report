%1）问代码：
function ymax = men(n)
x = unifrnd(-2*pi, 2*pi, 1, n);  %生成(连续)均匀分布的随机数
y = (1-x.^2).*sin(3*x);
ymax = max(y);
plot(x, y,'.')  %画图
title('1）问图像')
