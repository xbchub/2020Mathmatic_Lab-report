function frat2(x,y,d,n)
% x Ϊ�����εĶ���ĺ�����
% y Ϊ�����εĶ����������
% d Ϊ��ʼ�����α߳�
% n Ϊ��������
for p=1:n
    location_x=[];
    location_y=[];
    
    for q=1:length(x) %ÿ��С�����μ���һ��
        x1=x(q)+[0,d/3,2*d/3,0,2*d/3,0,d/3,2*d/3];
        y1=y(q)+[0,0,0,d/3,d/3,2*d/3,2*d/3,2*d/3];
        location_x=[location_x,x1];
        location_y=[location_y,y1];
    end
d=d/3;
x=location_x; 
y=location_y;
end
hold on
for q=1:length(x) %����ɫע�����������
    fill(x(q)+[0,d,d,0,0],y(q)+[0,0,d,d,0],'g')
end
hold off
axis off
axis equal %��������ͬ����
set(findobj(gcf,'type','patch'),'edgecolor','none') 