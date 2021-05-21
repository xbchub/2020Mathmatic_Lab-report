function dx = odefun3(t,x)
    dx = zeros(2,1); %列向量，分别存入x1和x2
    dx(1)= x(2); %第一个方程
    dx(2)= -20*x(2)-100*x(1); %第二个方程