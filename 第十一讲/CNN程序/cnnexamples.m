
clear all; close all; clc;    
load mnist_uint8;  
train_x = double(reshape(train_x',28,28,60000))/255;  %���ݹ�һ����[0 1]֮��
test_x = double(reshape(test_x',28,28,10000))/255;  %���ݹ�һ����[0 1]֮��
train_y = double(train_y');  
test_y = double(test_y');  
 
%% ex1   
%will run 1 epoch in about 200 second and get around 11% error.   
%With 100 epochs you'll get around 1.2% error  
  
cnn.layers = {  
    struct('type', 'i') %input layer  
struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer��6��5*5�ľ���ˣ����Եõ�6��outputmaps  
struct('type', 's', 'scale', 2) %sub sampling layer  ��2*2���²��������
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer ��12��5*5�ľ���ˣ����Եõ�12��outputmaps  


    struct('type', 's', 'scale', 2) %subsampling layer    ��2*2���²��������
};  %������һ��5�������磬����һ������㣬��δ�����ﶨ�塣
  
cnn = cnnsetup(cnn, train_x, train_y);  %ͨ���ú������������ʼȨ�ؾ����ƫ����г�ʼ��
  
opts.alpha = 1;  % ѧϰ��

opts.batchsize = 50; %ÿbatchsize��ͼ��һ��ѵ��һ�֣�����һ��Ȩֵ��  
% ѵ����������ͬ��������������ѵ����ʱ��  
% 1��ʱ�� 11.41% error  
% 5��ʱ�� 4.2% error  
% 10��ʱ�� 2.73% error  
opts.numepochs = 10;  %ÿ��epoch�ڣ�������ѵ�����ݽ���ѵ�������£�ѵ��ͼ�����/batchsize���������
  
cnn = cnntrain(cnn, train_x, train_y, opts);  %����ѵ��
  
 [er_test, bad_test] = cnntest(cnn, test_x, test_y);  %�������

%plot mean squared error  
plot(cnn.rL);  
%show test error  
disp(['10000 test images ' num2str(er_test*100) '% error']);  


 [er_train, bad_train] = cnntest(cnn, train_x, train_y);  %�������
disp(['60000 train images ' num2str(er_train*100) '% error']);  

