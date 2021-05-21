%Creat the function for jisi
%Let x(1)=x, x(2)=y

function dx=jisi(t,x,a,b,c)
s=sqrt((c-x(1))^2+(a*t-x(2))^2);
%dx=[b*(c-x(1))/s;b*(a*t-x(2))/s];
dx=[1;1];
dx(1)=b*(c-x(1))/s;
dx(2)=b*(a*t-x(2))/s;
