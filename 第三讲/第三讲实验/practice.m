% �ڶ�άƽ���ϻ���һ�Ե�ż���ӵĵ糡��ͼ��
k = 8.9875e+9;  % ����ϵ��
e_p = 1.602e-19; % �����ɴ�����
e_n = -e_p;  % �����ɴ�����
e_r = 2.8e-15;  % ��ɵİ뾶
% ָ�����䣺 d=<x,y<=d����������������
d = -e_r*40:e_r:e_r*40;
[x, y] = meshgrid(d);
dt = (max(d) - min(d)) / 10; % �趨�������Ӽ�ľ���
x_n = -dt / 2; y_n = 0;  % �趨�����ӵ�����ֵ
x_p = dt / 2; y_p = 0; % �趨�����ӵ�����ֵ
% �ֱ���������������Χһ��ĵ���
V1_min = k * e_n / e_r; V2_max = k * e_p / e_r;
V1 =  k * e_n ./ sqrt((x-x_n).^2 + (y-y_n).^2); % �����
V2 = k * e_p ./ sqrt((x-x_p).^2 + (y-y_p).^2); % �����
V1(V1==-Inf) = V1_min;  V1(V1<V1_min) = V1_min;
V2(V2==Inf)  = V2_max;  V2(V2>V2_max) = V2_max;
% ���õ���ԭ��������
V =  V1 + V2;
[E_x, E_y] = gradient(-V);
hold on; grid on;
% ��ż����һ���ֵ糡�ߴ������ɳ����� ����۵�������
% ���ƴ�����ɷ����ĵ糡�ߣ� ��Щ�糡��һ���ֻ�۵�������
% ����һ������������Զ
t = linspace(-pi, pi, 25);
sx = e_r * cos(t) + x_p; sy = e_r * sin(t) + y_p;
streamline(x, y, E_x, E_y, sx, sy);
% Ϊ����ɲ��伸����������Զ�ĵ糡��
sx = [min(d)/3*2, min(d),  min(d), min(d),  min(d)/3*2];
sy = [min(d),  min(d)/3*1, 0,  max(d)/3*1, max(d)];
streamline(x, y, E_x, E_y, sx, sy);
contour(x, y, V, linspace(min(V(:)), max(V(:)), 60));  % ���Ƶ�����
plot(x_n, y_n, 'ro',  x_n, y_n, 'r-', 'MarkerSize', 8); % ��������
plot(x_p, y_p, 'ro',  x_p, y_p, 'r+', 'MarkerSize', 8); % ��������
axis([min(d), max(d), min(d), max(d)]);
title('E-field of an electric dipole');
hold off;