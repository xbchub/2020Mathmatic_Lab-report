theta=0:0.01:4*pi;    
p=2*theta;        %  
subplot(2,1,1);
polar(theta,p,'r')
title('二维等速螺旋线')  %二维等速螺旋线

x = cos(theta);
y = sin(theta);
z = 2*theta;
subplot(2,1,2);
plot3(x,y,z,'b')
hold on;
plot3(x,-y,z,'g')
hold off;
title('三维等距螺旋线')  %三维等距螺旋线
