
%½âÎö·¨
syms a x(t)
dsolve(diff(x) == -a*x)


syms f(t)
dsolve(diff(f) == f + sin(t))


syms a b y(t)
dsolve(diff(y) == a*y, y(0) == b)


syms a y(t)
Dy = diff(y);
dsolve(diff(y, 2) == -a^2*y, y(0) == 1, Dy(pi/a) == 0)

syms x(t) y(t)
z = dsolve(diff(x) == y, diff(y) == -x)

syms a y(t)
dsolve(diff(y)==a/sqrt(y)+y,y(a)==1)

syms y(t)
dsolve(sqrt(diff(y))==sqrt(y)+1/y)

dsolve('Dy^2+y^2==1','s')

dsolve('D2y+4*Dy+29*y=0','y(0)=0,Dy(0)=15','x')

[x,y,z]=dsolve('Dx=2*x-3*y+3*z','Dy=4*x-5*y+3*z','Dz=4*x-4*y+2*z','t')
simplify(x),simplify(y),simplify(z)



