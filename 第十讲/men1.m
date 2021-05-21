%2）问代码：
function fm = men1(n)
x2 = unifrnd(10,20,1,n);  %生成(连续)均匀分布的随机数
x1 = x2+10;
x3 = unifrnd(-5,16,1,n);
f = zeros(1,n);
for i = 1: n  %n次循环
    if -x1(i)+2*x2(i)+2*x3(i)>=0 && x1(i)+2*x2(i)+2*x3(i)<=72  %满足不等式
        f(i) = x1(i)*x2(i)*x3(i);
    end
end
fm = max(f);  %求最大值
plot(f, '.')
title('2）问图像')
