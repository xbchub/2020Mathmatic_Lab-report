clear,clf,shg
%Set the definied time
%ts=0:0.05:0.5;
%
ts=0:0.1:1.6;
n=length(ts);
x0=[0 0];
a=35;b=40;c=15;
opt1=odeset('RelTol',1e-6,'AbsTol',1e-9);
[t,x]=ode45(@jisi,ts,x0,opt1,a,b,c);


%a=35;b=40;c=15;
%opt1=odeset('RelTol',1e-6,'AbsTol',1e-9);
%[t,x]=ode45(@jisi,ts,x0,opt1,a,b,c);

%exact solution x1=c
y1=a*t;
%output t,x(t),y(t) and draw x(t),y(t)
[t,x,y1]
plot(t,x),grid,gtext('x(t)','FontSize',16),
gtext('y(t)','FontSize',16),pause

%draw y(x): the position of tatch jisi
plot(x(:,1),x(:,2),'r*'),grid
xlabel('x','FontSize',16),ylabel('y','FontSize',16),pause

plot(x(:,1),x(:,2)),grid %»­º½Ïß

