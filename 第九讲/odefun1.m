function dy= odefun1(x,y)  %接受自变量x和因变量y的已知值
    dy = zeros(2,1); %列向量，分别存入y1和y2
    dy(1)= y(2); %第一个方程
    dy(2)= -y(1)-sin(2*x); %第二个方程