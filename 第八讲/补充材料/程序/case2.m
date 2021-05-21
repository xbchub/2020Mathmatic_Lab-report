clc
clear all
%ˮ�����������룺
%%�������ͼ
x = [7.0 10.5 13.0 17.5	34.0 40.5 44.5 48.0 56.0 61.0 68.5 76.5	80.5 91.0 96.0];  %�������ʱ������
x = [x 101.0 104.0 106.5 111.5 118.0 123.5 136.5 142.0 146.0 150.0 157.0 158.0];

y1 = [44 45 47 50 50 38 30 30 34 36 34 41 45 46 43 37 33 28 32 65 55 54	52 50 66 66 68];  %������Ÿ߶�����
y2 = [44 59 70 72 93 100 110 110 110 117 118 116 118 118 121 124 121 121 121 122 116 83 81 82 86 85 68];

scatter(x,y1,'b')
hold on
scatter(x,y2,'b')
title('�������ɢ��ͼ')

%%�������ղ�ֵ
ti= linspace(44,158.0,400);  %ȡ���ɽڵ�
yi1= itp1(x',y1',ti);
yi2= itp1(x',y2',ti);
plot(x,y1,'r+', ti,yi1,'r');
plot(x,y2,'r+', ti,yi2,'r');
legend('ԭʼ����','��ֵ����') 

%%�ֶ����Բ�ֵ
yi1= interp1(x,y1,ti,'linear');  %���÷ֶ����Բ�ֵ
yi2= interp1(x,y2,ti,'linear');
figure
plot(x,y2,'r+', ti,yi2, 'r');
plot(x,y2,'r+', ti,yi2, 'r');
legend('ԭʼ����','��ֵ����') 

%%����������ֵ
yi1= interp1(x,y1,ti,'spline');  %��������������ֵ
yi2= interp1(x,y2,ti,'spliner');
figure
plot(x,y2,'r+', ti,yi2, 'r');
plot(x,y2,'r+', ti,yi2, 'r');
legend('ԭʼ����','��ֵ����') 

%%���ΰ������ز�ֵ����չ��
yi1= interp1(x,y1,ti,'pchip');  %%�������ΰ������ز�ֵ
yi2= interp1(x,y2,ti,'pchip');
figure
plot(x,y2,'r+', ti,yi2, 'r');
plot(x,y2,'r+', ti,yi2, 'r');
legend('ԭʼ����','��ֵ����') 

%%����ʽ���
p3= polyfit(x,y1,3);
p5= polyfit(x,y1,5);
p6= polyfit(x,y1,6);
figure
plot(x,y1,'r+',ti,polyval(p3,ti),'r',ti,polyval(p5,ti),'r',ti,polyval(p6,ti),'r')
legend('��������', '3 �����', '5 �����', '6 �����') 

%%����ʵ��ֵ�Ͳ�ֵ
%��һ�μ��飺
% pp = pchip(t_,v)   %�����п��Դ�������һ�У�pp���ڼ�¼��ֵ����
% vi = ppval(pp,ti)  %ppval���ڼ���������ʽ����ti��pp�µ�ֵ
yi1 = interp1(x,y1,ti,'pchip')
S1(1,1) = trapz(ti,yi1)  %�������ΰ������ز�ֵ�µĻ���

yi1 = polyval(p6,ti);  
F1(1,1) = trapz(ti,yi1)  %�������ʽ����µĻ���

yi1 = interp1(x,y1,ti,'spline')
S2(1,1) = trapz(ti,yi1)   %��������������ֵ�µĻ���

%�ڶ��μ��飺
ti = linspace(10.954, 20.839,100);
yi1 = interp1(x,y1,ti,'pchip')
S1(1,2) = trapz(ti,yi1)  %�������ΰ������ز�ֵ�µĻ���

yi1 = polyval(p6,ti);  
F1(1,2) = trapz(ti,yi1)  %�������ʽ����µĻ���

yi1 = interp1(x,y1,ti,'spline')
S2(1,2) = trapz(ti,yi1)   %��������������ֵ�µĻ���

%�����μ��飺
ti = linspace(23.880, 25.908,50); 
yi1 = interp1(x,y1,ti,'pchip')
S1(1,3) = trapz(ti,yi1)  %�������ΰ������ز�ֵ�µĻ���

yi1= polyval(p6,ti);  
F1(1,3) = trapz(ti,yi1)  %�������ʽ����µĻ���

yi1 = interp1(x,y1,ti,'spline')
S2(1,3) = trapz(ti,yi1)   %��������������ֵ�µĻ���
