%问题三代码
clc
clear all
x = [15 20 30;  %输入投入关系
30 10 45;
20 60 0];
X = [100 200 150];  %总需求
X_rep = repmat(X,3,1);
A = x./X_rep;  %直接消耗矩阵
W = eye(3)-A;
dx = inv(W);  %变化量
X_changed = X'+15*(dx(:,1))+35*(dx(:,2))+30*(dx(:,3));  %改变后总产量
disp('1）问总产出：')
X_changed
disp('2）问总产出变化量：')
dx