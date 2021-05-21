function ode5(c_) 
    global c; %全局变量,odefun5必须也定义该全局变量
    %如果相同的变量在另一个函数中被声明为全局变量，那么这个变量所占有内存区域就是第一个函数中的相同变量。
    hold on
    tspan = linspace(0,4,100);
    for i=1:length(c_)
        c = c_(i);
        [t,x]= ode45('odefun5',tspan,[1,0]);
        text(t(10),x(10,1),['\leftarrow c=',num2str(c)])  %定义文本说明，向左
        plot(t,x(:,1))
    end
    hold off