function u = lorenzf(t,x)
global a b c
u = [a*(x(2)-x(1)), x(1)*(c - x(3)) - x(2), x(1)*x(2) - b*x(3)]';