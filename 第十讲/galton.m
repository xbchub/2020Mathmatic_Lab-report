function ballnump=galton(m,n,p)%输入参数分别为扔球次数m,钉子排数n,球向右的概率p:输出落入各格子中球的频率
    y0=2;%设置钉板底边高度
    ballnum=zeros(1,n+1);%记录球落入格子的频率
    p=0.5;
    q=0.5;
    for i=n+1:-1:1%设置钉子的位置
        x(i,1)=0.5*(n-i+1);y(i,1)=(n-i+1)+y0;
        for j=2:i
            x(i,j)=x(i,1)+(j-1)*1;y(i,j)=y(i,1);
        end
    end
%动画开始,模拟小球下落轨迹
mm=moviein(m);%创建动画矩阵
rand('state',sum(100*clock));%rand('state',sum(100*clock))依据系统时钟产生种子数
for i=1:m%模拟扔球m次
    s=rand(1,n);
    xi=x(1,1);yi=y(1,1);k=1;l=1;%小球遇到第一个钉子
    for j=l:n
        plot(x(1:n,:),y(1:n,:),'o',x(n+1,:),y(n+1,:),'-')%画钉子的位置
        axis([-2 n+2 0 y0+n+1])
        hold on
        k=k+1;%小球下落一格
        if s(j)>p
            l=l+0;%小球向左移
        else
            l=l+1;%小球向右移
        end
        xt=x(k,1);yt=y(k,1);%小球下落点的坐标
        plot([xi,xt],[yi,yt]);axis([-2 n+2 0 y0+n+1])%画小球运动轨迹
        xi=xt;yi=yt;
        mm(i)=getframe;%存储动画数据矩阵
    end
    ballnum(1)=ballnum(1)+1;%统计落入各个格子的球数
    ballnump=ba11num./m;%计算各个格子中球的频率
end
movie(mm,1)%播放动画矩阵一次
bar([0:n],ballnum),axis([-2 n+2 0 y0+n+1])%画各格子的频数图
hold off

