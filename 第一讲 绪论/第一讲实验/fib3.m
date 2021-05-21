function y=fib3(n)
    fn=[1,1];
    for i=3:n
        fn=[fn,fn(i-2)+fn(i-1)]
    end
    xn=1:n;
    fn=log(fn);
    y=polyfit(xn,fn,1);