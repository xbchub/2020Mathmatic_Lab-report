function y=fib4(n)
    fn1=[];
    for i=1:n
        fn1=[fn1,0.4476*1.618^i]; %用实验三的结论赋值
    end
    fn2=[1,1]; 
    for i=3:n 
        fn2=[fn2,fn2(i-2)+fn2(i-1)]; 
    end 
    x=1:n;
    plot(x,fn1,'b',x,fn2,'r*') %画图, fn1―蓝，fn2－红星
    legend('原始数据', '拟合数据')
