function ode5(c_) 
    global c; %ȫ�ֱ���,odefun5����Ҳ�����ȫ�ֱ���
    %�����ͬ�ı�������һ�������б�����Ϊȫ�ֱ�������ô���������ռ���ڴ�������ǵ�һ�������е���ͬ������
    hold on
    tspan = linspace(0,4,100);
    for i=1:length(c_)
        c = c_(i);
        [t,x]= ode45('odefun5',tspan,[1,0]);
        text(t(10),x(10,1),['\leftarrow c=',num2str(c)])  %�����ı�˵��������
        plot(t,x(:,1))
    end
    hold off