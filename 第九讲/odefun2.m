function dy= odefun2(t,y)
    dy = zeros(2,1); %列向量，分别存入y1和y2
    dy(1)= y(2); %第一个方程右边
    dy(2)= -0.01*y(2)-sin(y(1)); %第二个方程右边