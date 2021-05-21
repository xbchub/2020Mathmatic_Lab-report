clc; close all;
%% 数据导入及预处理
filename = "data.xlsx";
[trainData, testData] = dataPreprocess(filename);   % 得到训练集与测试集

% 划分输入数据与输出数据，并转置，用于归一化
trainInput = trainData(:, 1: 9)';
trainOutput = trainData(:, 10: 11)';
testInput = testData(:, 1: 9)';
testOutput = testData(:, 10: 11)';

% 数据归一化
[input, inputPS] = mapminmax(trainInput);
[output, outputPS] = mapminmax(trainOutput);
trainInputNorm = mapminmax('apply', trainInput, inputPS);
trainOutputNorm = mapminmax('apply', trainOutput, outputPS);
testInputNorm = mapminmax('apply', testInput, inputPS);
testOutputNorm = mapminmax('apply', testOutput, outputPS);

%% 神经网络训练
%定义BP前馈神经网络
net = newff(trainInputNorm,trainOutputNorm,9,{'tansig','purelin'},'trainlm');
%网络参数的设置
net.trainParam.epochs = 200;  %训练次数设置
net.trainParam.goal = 0.01;  %训练目标设置
net.trainParam.lr = 0.005;  %学习率设置
net.trainParam.mc = 0.9;  %动量因子的设置
net.trainParam.max_fail = 20;  % 最大确认失败次数

%<--------------------------------开始训练-------------------------------->%

net = train(net,trainInputNorm,trainOutputNorm);
%导入预测数据Datapredict
trainPredictNorm = sim(net,trainInputNorm);

%对预测数据反归一化
trainPredict = mapminmax('reverse',trainPredictNorm,outputPS); 

% 对训练集预测结果进行性能评价
[errorTrain, R2Train] = errorAnalysis(trainPredict,trainOutput);

%% 测试集测试
%测试集的预测输出
testPredictNorm = sim(net,testInputNorm);

%对预测数据反归一化
testPredict = mapminmax('reverse',testPredictNorm,outputPS);

% 对测试集预测结果进行性能评价
[errorTest, R2Test] = errorAnalysis(testPredict,testOutput);
