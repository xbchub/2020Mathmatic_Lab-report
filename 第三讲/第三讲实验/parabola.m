p = 4
ezplot(strcat('y^2-2*',num2str(p),'*x'));  %绘制四种标准抛物线
hold on
ezplot(strcat('y^2+2*',num2str(p),'*x'));
ezplot(strcat('x^2-2*',num2str(p),'*y'));
ezplot(strcat('x^2+2*',num2str(p),'*y'));
hold off
title('抛物线')
xlabel('x轴')
ylabel('y轴')
