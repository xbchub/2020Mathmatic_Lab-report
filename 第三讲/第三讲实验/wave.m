disp('������ֵ��EE�糡ǿ�ȣ�f��Ų�Ƶ�ʣ�x0λ�ã�t0ʱ��')  %�ⲿ�����Ҫ�Ĳ���
u0=4*pi*1e-7;  %�ŵ���
e0=1e-9/(36*pi);  %����ʳ���
Z0=(u0/e0)^0.5;  %���迹
f=1e8;  %��Ų���Ƶ��Ĭ��ֵ
w=2*pi*f;
k=w*(u0*e0)^0.5;  %����
EE=20;  %�糡ǿ��Ĭ��ֵ
HH=EE/Z0;
x=0:0.1:20;  %���������ϵĲ�����
mo=zeros(size(x));
Ez=EE*cos(k*x-w*t*1e-9);����
Hy=HH*cos(k*x-w*t*1e-9);
disp('x0��t0ʱ�̵ĵ糡ǿ�ȣ�')
Ez0=abs(EE*cos(k*x0-w*t0*1e-9))
disp('x0��t0ʱ�̵Ĵų�ǿ�ȣ�')
Hy0=abs(HH*cos(k*x0-w*t0*1e-9))
plot3(x,mo,Ez,'b');
hold on 
plot3(x,Hy,mo,'g');
plot3(x0,Hy0,Ez0,'*r')
hold off 
xlabel('��������')
ylabel('�ų�')
zlabel('�糡')
title('ƽ���Ų�����ʾ��ͼ')
legend('�糡����','�ų�����','x0����')