function ode4a(cval) 
    global c
    c=cval; %����ϵ��
    tspan=linspace(0,4,200);
    [t,xt]= ode45('odefun4',tspan,[1,0]);
    animinit('onecart1 Animation')  %��ʼ��ͼ��animinit����
    axis([-2 6 -10 10]);  %�����������С
    hold on 
    u=2;
    xy=[ 0, 0, 0, 0, u, u, u+1, u+1, u, u;
        -1.2, 0, 1.2, 0, 0, 1.2, 1.2, -1.2, -1.2, 0];
    x=xy(1,:);y=xy(2,:);
    plot([-10 20],[-1.4 -1.4],'b-','LineWidth',2);
    hndl=plot(x,y,'b-','EraseMode','XOR','LineWidth',2);  
    %��EraseMode�����Կ���ʵ����ʾ�¶��󣬲����ɶ��󣬶��ֲ��ƻ�����ͼ��
    %xor ��ʽ����Ļ��ƺͲ����ɱ�����ɫ����Ļ��ɫ����������
    %ֻ��������Ļ��ɫ��һ�µľɶ���ĵ㣬ֻ���ƺ���Ļ��ɫ��һ�µ��¶���ĵ�
    set(gca,'UserData',hndl);  %���ƻ���ͼ
    for i=1:length(xt)
    	u=2+5*xt(i);
        x=[0, 0, 0, 0, u, u, u+1, u+1, u, u];
        hndl=get(gca,'UserData');
        set(hndl,'XData',x);  %���ƻ���ͼ
        pause(0.02);
        drawnow  %ˢ����Ļdrawnow����
    end