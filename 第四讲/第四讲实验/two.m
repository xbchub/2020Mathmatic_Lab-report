%���������
clc
clear all
x = [30 20 50;
    20 30 35;
    16 18 2];
X = [250 200 100];  %�ܲ�Ʒ���
X_rep = repmat(X,3,1);
A = x./X_rep;
W = eye(size(A, 1)) -A;  %I-A
dx = inv(W);
disp('�ƻ��ı����ܲ���:')
X_changed = X'-30*(dx(:,1))+36*(dx(:,3))  %�ƻ��ı����ܲ���,�ñ仯����
disp('�ƻ��ı��ĸ�����Ͷ��:')
x_changed = A.*repmat(X_changed',3,1)  %�ƻ��ı��ĸ�����Ͷ��
