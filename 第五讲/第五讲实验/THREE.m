%问题三代码
clc
C = [70 66;  %将明文数字编码为矩阵M
    62 80;
    108 76];
K = [1 -1 1;  %定义密钥矩阵K
    1 1 -1;
    -1 1 1];
disp('解密后明文为：')
M = mod(K\C,128)  %解密密文