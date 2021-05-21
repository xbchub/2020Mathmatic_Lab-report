
clear all; close all; clc;    
load mnist_uint8;  
train_x = double(reshape(train_x',28,28,60000))/255;  %数据归一化至[0 1]之间
test_x = double(reshape(test_x',28,28,10000))/255;  %数据归一化至[0 1]之间
train_y = double(train_y');  
test_y = double(test_y');  
 
%% ex1   
%will run 1 epoch in about 200 second and get around 11% error.   
%With 100 epochs you'll get around 1.2% error  
  
cnn.layers = {  
    struct('type', 'i') %input layer  
struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer，6个5*5的卷积核，可以得到6个outputmaps  
struct('type', 's', 'scale', 2) %sub sampling layer  ，2*2的下采样卷积核
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer ，12个5*5的卷积核，可以得到12个outputmaps  


    struct('type', 's', 'scale', 2) %subsampling layer    ，2*2的下采样卷积核
};  %定义了一个5层神经网络，还有一个输出层，并未在这里定义。
  
cnn = cnnsetup(cnn, train_x, train_y);  %通过该函数，对网络初始权重矩阵和偏向进行初始化
  
opts.alpha = 1;  % 学习率

opts.batchsize = 50; %每batchsize张图像一起训练一轮，调整一次权值。  
% 训练次数，用同样的样本集。我训练的时候：  
% 1的时候 11.41% error  
% 5的时候 4.2% error  
% 10的时候 2.73% error  
opts.numepochs = 10;  %每个epoch内，对所有训练数据进行训练，更新（训练图像个数/batchsize）网络参数
  
cnn = cnntrain(cnn, train_x, train_y, opts);  %网络训练
  
 [er_test, bad_test] = cnntest(cnn, test_x, test_y);  %网络测试

%plot mean squared error  
plot(cnn.rL);  
%show test error  
disp(['10000 test images ' num2str(er_test*100) '% error']);  


 [er_train, bad_train] = cnntest(cnn, train_x, train_y);  %网络测试
disp(['60000 train images ' num2str(er_train*100) '% error']);  

