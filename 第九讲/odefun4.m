function dx= odefun4(t,x)
    global c; %ȫ�ֱ���
    dx = zeros(2,1); %���������ֱ����x1��x2
    dx(1)= x(2); %��һ������
    dx(2)= -20*c*x(2)-100*x(1); %�ڶ�������