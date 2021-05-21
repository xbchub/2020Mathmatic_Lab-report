clc; close all;
%% ���ݵ��뼰Ԥ����
filename = "data.xlsx";
[trainData, testData] = dataPreprocess(filename);   % �õ�ѵ��������Լ�

% ��������������������ݣ���ת�ã����ڹ�һ��
trainInput = trainData(:, 1: 9)';
trainOutput = trainData(:, 10: 11)';
testInput = testData(:, 1: 9)';
testOutput = testData(:, 10: 11)';

% ���ݹ�һ��
[input, inputPS] = mapminmax(trainInput);
[output, outputPS] = mapminmax(trainOutput);
trainInputNorm = mapminmax('apply', trainInput, inputPS);
trainOutputNorm = mapminmax('apply', trainOutput, outputPS);
testInputNorm = mapminmax('apply', testInput, inputPS);
testOutputNorm = mapminmax('apply', testOutput, outputPS);

%% ������ѵ��
%����BPǰ��������
net = newff(trainInputNorm,trainOutputNorm,9,{'tansig','purelin'},'trainlm');
%�������������
net.trainParam.epochs = 200;  %ѵ����������
net.trainParam.goal = 0.01;  %ѵ��Ŀ������
net.trainParam.lr = 0.005;  %ѧϰ������
net.trainParam.mc = 0.9;  %�������ӵ�����
net.trainParam.max_fail = 20;  % ���ȷ��ʧ�ܴ���

%<--------------------------------��ʼѵ��-------------------------------->%

net = train(net,trainInputNorm,trainOutputNorm);
%����Ԥ������Datapredict
trainPredictNorm = sim(net,trainInputNorm);

%��Ԥ�����ݷ���һ��
trainPredict = mapminmax('reverse',trainPredictNorm,outputPS); 

% ��ѵ����Ԥ����������������
[errorTrain, R2Train] = errorAnalysis(trainPredict,trainOutput);

%% ���Լ�����
%���Լ���Ԥ�����
testPredictNorm = sim(net,testInputNorm);

%��Ԥ�����ݷ���һ��
testPredict = mapminmax('reverse',testPredictNorm,outputPS);

% �Բ��Լ�Ԥ����������������
[errorTest, R2Test] = errorAnalysis(testPredict,testOutput);
