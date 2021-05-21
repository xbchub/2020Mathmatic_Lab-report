%%清空环境变量
clc
clear
close all

%%导入数据(需要手动添加数据)
%%load data input ourput

%%读取input当中的行数
i=size(input,1);

%%随机排序
k=rand(1,i);
[m,n]=sort(k);

%%选择训练数据和预测数据
input_train=input(n(1:i),:)';
output_train=output(n(1:i));
input_test=input(n(i-45:i),:)';
output_test=output(n(i-45:i));

%%数据归一化
[inputn,inputps]=mapminmax(input_train);
[outputn,outputps]=mapminmax(output_train);

%%BP神经网络训练
%%初始化网络结构，调节隐藏层层数，学习率
net=newff(inputn,outputn,5);
net.trainParam.lr=0.01;
net.trainParam.goal=0.00004;
net.trainParam.show=50;
net.trainParam.max_fail=10;

%网络训练
net=train(net,inputn,outputn);

%% BP网络预测
%预测数据归一化
inputn_test=mapminmax('apply',input_test,inputps);
 
%%BP网络预测输出
an=sim(net,inputn_test);

%网络输出反归一化
BPoutput=mapminmax('reverse',an,outputps);
plot([0,50],[-0.1,-0.1],'red')
%% 结果分析
figure(1)
plot(BPoutput,':og');
hold on
plot(output_test,'-*');
legend('预测输出','fontsize')
ylabel('函数输出','fontsize',12)
xlabel('样本','fontsize',12)

%预测误差
figure(2)
error=BPoutput-output_test;
plot(error,'-*')
title('BP网络预测误差','fontsize',12)
ylabel('误差','fontsize',12)
xlabel('样本','fontsize',12)

figure(3)
plot((output_test-BPoutput)./BPoutput,'-*')
hold on
plot([0,50],[0.1,0.1],'red');
hold on 
plot([0,50],[-0.1,-0.1],'red');
title('神经网络预测误差百分比')
%%计算平均误差
errorsum = sum(abs((output_test-BPoutput)./BPoutput))/43