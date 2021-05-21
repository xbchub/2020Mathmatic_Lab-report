function dx=stiff1(t,x)
dx=[x(1)+2*x(2);-(10^6+1)*x(1)-(10^6+2)*x(2)];
