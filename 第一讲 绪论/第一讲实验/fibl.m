function fibl(n)  
    fn=[1,1];  %新建一个数列，并赋予两个初值
    for i=3:n
        fn=[fn,fn(i-2)+fn(i-1)]; %将添加的数值键入数列
    end
    plot(fn)  %画图像