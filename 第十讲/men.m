%1���ʴ��룺
function ymax = men(n)
x = unifrnd(-2*pi, 2*pi, 1, n);  %����(����)���ȷֲ��������
y = (1-x.^2).*sin(3*x);
ymax = max(y);
plot(x, y,'.')  %��ͼ
title('1����ͼ��')
