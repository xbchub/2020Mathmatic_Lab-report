function fib2(n)
    fn=[1,1];
    for i=3:n
        fn=[fn,fn(i-2)+fn(i-1)];
    end
    fn=log(fn);
    plot(fn)