t = 0:pi/50:2*pi
x = '16*sin(t).^3'
y = '13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t)'
ezplot(x,y,'-b')
xlabel('x��')
ylabel('y��')
title('��������')