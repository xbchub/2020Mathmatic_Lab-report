%%Koch���߱���
function frat4(k) %��ʾ�ȱ������ε���k �κ��ͼ��
A=[cos(pi/3) -sin(pi/3);sin(pi/3) cos(pi/3)]; %���ڼ����µĽ��
p=[0 0;10 0]; %��Ž������
n=1;
for s=1:k
    j=0;
    for i=1:n 
        q1=p(i,:);  %Ŀǰ�߶ε��������
        q2=p(i+1,:); %Ŀǰ�߶ε��յ�����
        d=(q2-q1)/3;
        j=j+1;a(j,:)=q1; 
        j=j+1;a(j,:)=q1+d; 
        j=j+1;a(j,:)=q1+d+d*A';
        j=j+1;a(j,:)=q1+2*d; 
    end
    n=4*n;  
    clear p %��� p 
    p=[a;q2]; %����װ�ر��ε������ȫ�����
end
 
plot(p(:,1),p(:,2)) ;%��ʾ����������ͼ
fill(p(:,1),p(:,2),'k') %�����ɫ
set(findobj(gcf,'type','patch'),'edgecolor','none')
axis off
axis equal
