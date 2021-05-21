ezplot('x^2/4-y^2/3-1',[-10,10])  %隐函数直接绘制双曲线
title('双曲线')
xlabel('x轴')
ylabel('y轴')
hold on
plot(x, 2*x/sqrt(3), 'b-')  %绘制渐近线
plot(x, -2*x/sqrt(3), 'm-')
hold off
legend('hyperbola', 'y1', 'y2')  %添加图例