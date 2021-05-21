% lorenz �������
%������a, b, c
%a��b�ı�׼ֵΪ ��10��8/3
%'lorenzf.m' ������Lorenz����
% ���� 
% ��ʼʱ��ͽ���ʱ��
%ode45���
clear all
global a b c
a=10.;b=8./3.; c=28.; 
t0=0; tf=40;
x0=[10 10 10]; 
tic
[tout, xout] = ode45('lorenzf', [t0, tf], x0);
toc
% ��ͼ
figure(1);
hp=plot3(xout(:,1), xout(:,2), xout(:,3)); 
set(hp,'LineWidth',0.1);   
box on;   
xlabel('x','FontSize',10);
ylabel('y','FontSize',10);   
zlabel('z','FontSize',10);
axis([-20 20 -40 40 0 60]);
set(gca,'CameraPosition',[200 -200 200],'FontSize',10);
