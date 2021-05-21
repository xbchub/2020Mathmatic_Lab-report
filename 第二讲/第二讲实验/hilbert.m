m=5
hilb=zeros(m,m)
for i=1:m
    for j=1:m
        hilb(i,j)=1/(i+j-1);
    end
end
disp('行列式为：')
det(hilb)
disp('逆矩阵为：')
inv(hilb)
disp('特征值为：')
eig(hilb)
[u,v,w]=eig(hilb);
disp('左特征向量为：')
w
disp('右特征向量为：')
v
[V,j]=jordan(hilb);
disp('jordan分解结果为：')
j