ezplot('x^2/4-y^2/3-1',[-10,10])  %������ֱ�ӻ���˫����
title('˫����')
xlabel('x��')
ylabel('y��')
hold on
plot(x, 2*x/sqrt(3), 'b-')  %���ƽ�����
plot(x, -2*x/sqrt(3), 'm-')
hold off
legend('hyperbola', 'y1', 'y2')  %���ͼ��