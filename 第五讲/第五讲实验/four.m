%问题四代码（参考网上资料）
clc
clear all
photo = imread('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=797069786,413509340&fm=26&gp=0.jpg');
figure;imshow(photo)
title('原图')
[M,N]  = size(photo);
Rm = randsample(M,M)';
Mchange = [1:1:M;Rm];
Rn = randsample(N,N)';
Nchange = [1:1:N;Rn];
 
 
%打乱行顺序
photo (Mchange(1,:),:) = photo (Mchange(2,:),:);
figure;imshow(photo)
title('行加密后图像')
%打乱列顺序
photo (:,Nchange(1,:)) = photo (:,Nchange(2,:));
figure;imshow(photo)
title('列加密后图像')
%列变换还原
photo (:,Nchange(2,:)) = photo (:,Nchange(1,:));
figure;imshow(photo)
title('列解密后图像')
%行变换还原
photo (Mchange(2,:),:) = photo (Mchange(1,:),:);
figure;imshow(photo)
title('解密后图像')
