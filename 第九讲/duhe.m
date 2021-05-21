function dx=duhe(t,x)%建立名为duhe的函数M文件
    a=1;b=2;
    s=sqrt(x(1)^2+x(2)^2);
    dx=[a-b*x(1)/s;-b*x(2)/s];%以向量形式表示方程组