function frat6(c,res,iter,xc,yc,xoom)
%Julia ��
%c Ϊ������ res ��Ŀ��ֱ��ʣ�iter ��ѭ��������
%��xc,yc����ͼ�����ģ�xoom �ǷŴ���
x0=xc-2/xoom;
x1=xc+2/xoom;
y0=yc-2/xoom;
y1=yc+2/xoom;
x=linspace(x0,x1,res);
y=linspace(y0,y1,res);
[xx,yy]=meshgrid(x,y);
z=xx+yy*1i; 
N=zeros(res,res);
C=c*ones(res,res);
for k=1:iter 
    z=z.^2+C;
    N(abs(z)>2)=k;
    C(abs(z)>2)=0;
    z(abs(z)>2)=0;
end
colormap jet  %colormap map����ǰͼ������ɫͼ����ΪԤ�������ɫͼ֮һ��jet��һ�������������ʽ���� Jet ��ɫͼ
image(x,y,N);  %�����꣬ȷ��������ɫ
axis square  %axis square ��ǰ����ϵͼ������Ϊ����axis equal ����������Ķ���ϵ�������ֵͬ