function frat5(res,iter,xc,yc,xoom)
%Mandelbrot
% res ��Ŀ��ֱ��ʣ�iter ��ѭ��������
%��xc,yc����ͼ�����ģ�xoom �ǷŴ���
x0=xc-2/xoom;
x1=xc+2/xoom;
y0=yc-2/xoom;
y1=yc+2/xoom;
x=linspace(x0,x1,res); 
y=linspace(y0,y1,res); 
[xx,yy]=meshgrid(x,y); 
z=xx+yy*1i;
C=z;
N=zeros(res,res); %��ʼ��N�����ո���N���Ը������Ⱦɫ
tic	% ��ʾ tic �� toc ��ĳ�������ʱ��
for k=1:iter
    z=z.^2+C;	%�Կռ���ÿ�㶼���е���
    N(abs(z)>4)=k; %���ݰ뾶Ϊ 4������ʱ�� k,δ����Ϊ 0 
    z(abs(z)>4)=0;
    C(abs(z)>4)=0;
end
imshow(N,[]);
toc