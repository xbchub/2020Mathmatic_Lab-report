clc
clear all

%%模板
syms p;
A = [0.4 0.3;-p 1.2];  %建立捕食者矩阵
[r,lambda] = eig(A)  % 求A的特征值和对应的特征向量 
[lambda_norm,I] = sort(diag(abs(lambda)),'descend'); %按特征值的绝对值降序排列 
temp = diag(lambda); 
lambda = temp(I);  % 输出按特征值的绝对值降序排列的特征值 
r = r(:,I)  % 与特征值对应的特征向量


%% 问题1）代码
p = 0.325;
[lambda_norm,I] = sort(diag(abs(lambda)),'descend'); %按特征值的绝对值降序排列 
temp = diag(lambda); 
lambda = temp(I);  % 输出按特征值的绝对值降序排列的特征值 
lambda1 = simplify(subs(lambda))  %简化函数(简化后才能得到分数结果进行下一步操作)加求解函数
r1 = simplify(subs(r))

%% 问题2）代码
p = 0.5;
[lambda_norm,I] = sort(diag(abs(lambda)),'descend'); %按特征值的绝对值降序排列 
temp = diag(lambda); 
lambda = temp(I);  % 输出按特征值的绝对值降序排列的特征值 
lambda2 = simplify(subs(lambda))  %简化函数(简化后才能得到分数结果进行下一步操作)加求解函数
r2 = simplify(subs(r))

%% 问题3）代码
p1 = solve(lambda==[1;1])  %特征值确定为1
p = p1;
[lambda_norm,I] = sort(diag(abs(lambda)),'descend'); %按特征值的绝对值降序排列 
temp = diag(lambda); 
lambda = temp(I);  % 输出按特征值的绝对值降序排列的特征值 
lambda3 = simplify(subs(lambda))  %简化函数(简化后才能得到分数结果进行下一步操作)加求解函数
r3 = simplify(subs(r))