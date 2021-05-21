%%����һ����
% ��ʳ��-����ʳ�߽��ͼ���ʾ
clear, clc
a = -20*100; b = -a; c = a; d = b; p = 0.1;	%ȷ����ͼ��Χ
n = 100;	%���е�������
xlabel('|\lambda| >1,|u|<1') 
axis([0 b 0 d]), grid on, hold on 
x = linspace(a,b,30);
A = [0.5 0.4;-0.104 1.1]	%����ֵ����ֵ<1
[pc,lambda] = eig(A)	%�� A ������ֵ�Ͷ�Ӧ����������
[Y,I] = sort(diag(abs(lambda)),'descend')	%������ֵ�ľ���ֵ�������� 
temp = diag(lambda)
lambda = temp(I)	%���������ֵ�ľ���ֵ�������е�����ֵ
pc = -pc(:,I)
z1 = pc(2,1)/pc(1,1)*x	%�������� v1
z2 = pc(2,2)/pc(1,2)*x	%�������� v2 
h = plot(x,z1),set(h,'linewidth',2), text(x(7),z1(7)-100,'v1')
h = plot(x,z2),set(h,'linewidth',2), text(x(20),z2(20)-100,'v2') 
button = 1;
while button == 1
    [xi yi button] = ginput(1);	%�����ѡ��ʼ��
    plot(xi,yi,'go'),hold on
    X0 = [xi;yi];
    X = X0;
    for i=1:n
        X = [A*X, X0];	%�����ַ�ʽ����������ͼ 
        h = plot(X(1,1),X(2,1),'R.',X(1,1:2),X(2,1:2),'r-'); 
        hold on 
        text(X0(1,1),X0(2,1),'x0')
        quiver([X(1,2),1]',[X(2,2),1]',[X(1,1)-X(1,2),0]',[X(2,1)-X(2,2),0]',p)
        set(h,'MarkerSize',6),grid,
    end
end

%%���������
% P8_3.m
A = [0 0 0.33;0.3 0 0;0 0.71 0.94];
[pc,lambda] = eig(A);	%��A ������ֵ�Ͷ�Ӧ����������
[Y,I] = sort(diag(abs(lambda)),'descend');  %������ֵ�ľ���ֵ��������
temp = diag(lambda);
lambda = temp(I)	%���������ֵ�ľ���ֵ�������е�����ֵ
lambda_norm = [norm(lambda(1));
norm(lambda(2));
norm(lambda(3))]
% ��������ֵ�ľ���ֵ
pc = pc(:,I)	%������ֵ��Ӧ����������
