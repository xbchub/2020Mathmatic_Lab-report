%问题二代码
clc
clear all
x = [30 20 50;
    20 30 35;
    16 18 2];
X = [250 200 100];  %总产品情况
X_rep = repmat(X,3,1);
A = x./X_rep;
W = eye(size(A, 1)) -A;  %I-A
dx = inv(W);
disp('计划改变后的总产量:')
X_changed = X'-30*(dx(:,1))+36*(dx(:,3))  %计划改变后的总产量,用变化量求
disp('计划改变后的各部门投入:')
x_changed = A.*repmat(X_changed',3,1)  %计划改变后的各部门投入
