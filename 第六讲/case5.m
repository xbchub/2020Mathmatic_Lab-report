A = [1,0.5,0;0,0.5,1;0,0,0];

%% 问题（1）
[pc,lambda] = eig(A);              % 求 A 的特征值和对应的特征向量 
[lambda_norm,I] = sort(diag(abs(lambda)),'descend'); %对特征值的绝对值降序排列 
temp = diag(lambda); 
lambda = temp(I)                   % 输出按特征值的绝对值降序排列的特征值 
pc = pc(:,I)                       % 与特征值对应的特征向量

%% 问题（2）
x0 = [0.8; 0.2; 0];                % 基因型的初始矩阵
x20 = A ^ 20 * x0                  % 20年后的基因分布
