theta=0:0.01:4*pi;    
p=2*theta;        %  
subplot(2,1,1);
polar(theta,p,'r')
title('��ά����������')  %��ά����������

x = cos(theta);
y = sin(theta);
z = 2*theta;
subplot(2,1,2);
plot3(x,y,z,'b')
hold on;
plot3(x,-y,z,'g')
hold off;
title('��ά�Ⱦ�������')  %��ά�Ⱦ�������
