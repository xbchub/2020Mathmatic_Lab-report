%ɢ�����ݲ�ֵ����
clc
clear all
x = 2*rand(5000,1)-1; 
y = 2*rand(5000,1)-1; 
z = 2*rand(5000,1)-1;
v = x.^2 + y.^2 + z.^2;

d = -0.8:0.05:0.8;
[xq,yq,zq] = meshgrid(d,d,0)

vq = griddata(x,y,z,v,xq,yq,zq,'natural');%ɢ���ֵ,ͨ��v=f(x,y,z)���һ��������

surf(xq,yq,vq);

set(gca,'XTick',[-1 -0.5 0 0.5 1]);
set(gca,'YTick',[-1 -0.5 0 0.5 1]);
