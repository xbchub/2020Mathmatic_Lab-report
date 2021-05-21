%%问题一代码
% 捕食者-被捕食者解的图像表示
clear, clc
a = -20*100; b = -a; c = a; d = b; p = 0.1;	%确定画图范围
n = 100;	%序列迭代次数
xlabel('|\lambda| >1,|u|<1') 
axis([0 b 0 d]), grid on, hold on 
x = linspace(a,b,30);
A = [0.5 0.4;-0.104 1.1]	%特征值绝对值<1
[pc,lambda] = eig(A)	%求 A 的特征值和对应的特征向量
[Y,I] = sort(diag(abs(lambda)),'descend')	%对特征值的绝对值降序排列 
temp = diag(lambda)
lambda = temp(I)	%输出按特征值的绝对值降序排列的特征值
pc = -pc(:,I)
z1 = pc(2,1)/pc(1,1)*x	%特征向量 v1
z2 = pc(2,2)/pc(1,2)*x	%特征向量 v2 
h = plot(x,z1),set(h,'linewidth',2), text(x(7),z1(7)-100,'v1')
h = plot(x,z2),set(h,'linewidth',2), text(x(20),z2(20)-100,'v2') 
button = 1;
while button == 1
    [xi yi button] = ginput(1);	%用鼠标选初始点
    plot(xi,yi,'go'),hold on
    X0 = [xi;yi];
    X = X0;
    for i=1:n
        X = [A*X, X0];	%用这种方式迭代，并画图 
        h = plot(X(1,1),X(2,1),'R.',X(1,1:2),X(2,1:2),'r-'); 
        hold on 
        text(X0(1,1),X0(2,1),'x0')
        quiver([X(1,2),1]',[X(2,2),1]',[X(1,1)-X(1,2),0]',[X(2,1)-X(2,2),0]',p)
        set(h,'MarkerSize',6),grid,
    end
end

%%问题二代码
% P8_3.m
A = [0 0 0.33;0.3 0 0;0 0.71 0.94];
[pc,lambda] = eig(A);	%求A 的特征值和对应的特征向量
[Y,I] = sort(diag(abs(lambda)),'descend');  %对特征值的绝对值降序排列
temp = diag(lambda);
lambda = temp(I)	%输出按特征值的绝对值降序排列的特征值
lambda_norm = [norm(lambda(1));
norm(lambda(2));
norm(lambda(3))]
% 三个特征值的绝对值
pc = pc(:,I)	%与特征值对应的特征向量
