clc
clear all

%%ģ��
syms p;
A = [0.4 0.3;-p 1.2];  %������ʳ�߾���
[r,lambda] = eig(A)  % ��A������ֵ�Ͷ�Ӧ���������� 
[lambda_norm,I] = sort(diag(abs(lambda)),'descend'); %������ֵ�ľ���ֵ�������� 
temp = diag(lambda); 
lambda = temp(I);  % ���������ֵ�ľ���ֵ�������е�����ֵ 
r = r(:,I)  % ������ֵ��Ӧ����������


%% ����1������
p = 0.325;
[lambda_norm,I] = sort(diag(abs(lambda)),'descend'); %������ֵ�ľ���ֵ�������� 
temp = diag(lambda); 
lambda = temp(I);  % ���������ֵ�ľ���ֵ�������е�����ֵ 
lambda1 = simplify(subs(lambda))  %�򻯺���(�򻯺���ܵõ��������������һ������)����⺯��
r1 = simplify(subs(r))

%% ����2������
p = 0.5;
[lambda_norm,I] = sort(diag(abs(lambda)),'descend'); %������ֵ�ľ���ֵ�������� 
temp = diag(lambda); 
lambda = temp(I);  % ���������ֵ�ľ���ֵ�������е�����ֵ 
lambda2 = simplify(subs(lambda))  %�򻯺���(�򻯺���ܵõ��������������һ������)����⺯��
r2 = simplify(subs(r))

%% ����3������
p1 = solve(lambda==[1;1])  %����ֵȷ��Ϊ1
p = p1;
[lambda_norm,I] = sort(diag(abs(lambda)),'descend'); %������ֵ�ľ���ֵ�������� 
temp = diag(lambda); 
lambda = temp(I);  % ���������ֵ�ľ���ֵ�������е�����ֵ 
lambda3 = simplify(subs(lambda))  %�򻯺���(�򻯺���ܵõ��������������һ������)����⺯��
r3 = simplify(subs(r))