A = [0.4,0.3;-0.325,1.2];
[pc,lambda] = eig(A);
[Y,I] = sort(diag(abs(lambda)),'descend');
temp = diag(lambda);
lambda = temp(I)
pc = pc(:,I)

a=-20*100;b=-a;c=a;d=b;p=0.1;
n=100;
xlabel('|\lambda|>1,|u|<1')
axis([a b c d]),grid on,hold on
x=linspace(a,b,30);
A=[0.4,0.3;-0.325,1.2];
[pc,lambda]=eig(A);
[Y,I]=sort(diag(abs(lambda)),'descend');
temp=diag(lambda);
lambda=temp(I)
pc=pc(:,I)
pc=-pc;
z1=pc(2,1)/pc(1,1)*x;
z2=pc(2,2)/pc(1,2)*x;
h=plot(x,z1),set(h,'linewidth',2),text(x(20),z1(20)-100,'v1')
h=plot(x,z2),set(h,'linewidth',2),text(x(20),z2(20)-100,'v2')
button=1;
while button==1
     [xi,yi,button]=ginput(1);
     plot(xi,yi,'go'),hold on
     X0=[xi;yi];
     X=X0;
     for i=1:n
         X=[A*X,X0];
         h=plot(X(1,1),X(2,1),'R',X(1,1:2),X(2,1:2),'r-');hold on
         text(X0(1,1),X0(2,1),'x0')
         quiver([X(1,2),1]',[X(2,2),1]',[X(1,1)-X(1,2),0]',[X(2,1)-X(2,2),0]',p)
         set(h,'MarkerSize',6),grid,
     end
end