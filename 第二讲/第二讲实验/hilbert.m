m=5
hilb=zeros(m,m)
for i=1:m
    for j=1:m
        hilb(i,j)=1/(i+j-1);
    end
end
disp('����ʽΪ��')
det(hilb)
disp('�����Ϊ��')
inv(hilb)
disp('����ֵΪ��')
eig(hilb)
[u,v,w]=eig(hilb);
disp('����������Ϊ��')
w
disp('����������Ϊ��')
v
[V,j]=jordan(hilb);
disp('jordan�ֽ���Ϊ��')
j