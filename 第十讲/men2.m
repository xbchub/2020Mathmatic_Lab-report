%3���ʴ��룺
function fmax = men2(n)
x = unifrnd(-1.5,1.5,1,n);  %����(����)���ȷֲ��������
y = unifrnd(-1.5,1.5,1,n);
f = (x.^2+2*y.^2+x.*y).*exp(-x.^2-y.^2);  %���뷽��
fmax = max(f);  %�����ֵ
plot3(x, y, f, '.')
title('3����ͼ��')
grid