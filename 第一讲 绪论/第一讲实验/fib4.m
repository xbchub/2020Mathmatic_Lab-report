function y=fib4(n)
    fn1=[];
    for i=1:n
        fn1=[fn1,0.4476*1.618^i]; %��ʵ�����Ľ��۸�ֵ
    end
    fn2=[1,1]; 
    for i=3:n 
        fn2=[fn2,fn2(i-2)+fn2(i-1)]; 
    end 
    x=1:n;
    plot(x,fn1,'b',x,fn2,'r*') %��ͼ, fn1�D����fn2������
    legend('ԭʼ����', '�������')
