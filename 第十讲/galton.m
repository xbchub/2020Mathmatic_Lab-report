function ballnump=galton(m,n,p)%��������ֱ�Ϊ�������m,��������n,�����ҵĸ���p:�����������������Ƶ��
    y0=2;%���ö���ױ߸߶�
    ballnum=zeros(1,n+1);%��¼��������ӵ�Ƶ��
    p=0.5;
    q=0.5;
    for i=n+1:-1:1%���ö��ӵ�λ��
        x(i,1)=0.5*(n-i+1);y(i,1)=(n-i+1)+y0;
        for j=2:i
            x(i,j)=x(i,1)+(j-1)*1;y(i,j)=y(i,1);
        end
    end
%������ʼ,ģ��С������켣
mm=moviein(m);%������������
rand('state',sum(100*clock));%rand('state',sum(100*clock))����ϵͳʱ�Ӳ���������
for i=1:m%ģ������m��
    s=rand(1,n);
    xi=x(1,1);yi=y(1,1);k=1;l=1;%С��������һ������
    for j=l:n
        plot(x(1:n,:),y(1:n,:),'o',x(n+1,:),y(n+1,:),'-')%�����ӵ�λ��
        axis([-2 n+2 0 y0+n+1])
        hold on
        k=k+1;%С������һ��
        if s(j)>p
            l=l+0;%С��������
        else
            l=l+1;%С��������
        end
        xt=x(k,1);yt=y(k,1);%С������������
        plot([xi,xt],[yi,yt]);axis([-2 n+2 0 y0+n+1])%��С���˶��켣
        xi=xt;yi=yt;
        mm(i)=getframe;%�洢�������ݾ���
    end
    ballnum(1)=ballnum(1)+1;%ͳ������������ӵ�����
    ballnump=ba11num./m;%����������������Ƶ��
end
movie(mm,1)%���Ŷ�������һ��
bar([0:n],ballnum),axis([-2 n+2 0 y0+n+1])%�������ӵ�Ƶ��ͼ
hold off

