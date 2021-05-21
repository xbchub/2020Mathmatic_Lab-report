%% ���ݴ���
filename = "data.xlsx";
data = xlsread(filename);
[nanRows, ~] = find(isnan(data));           % �ҵ�����NaN����
data(nanRows, :) = [];                      % ɾ������NaN����
[zeroRows, ~] = find(data == 0);
data(zeroRows, :) = [];

% �õ��쳣�����������ı�ǩ
labels = ones(size(data, 1));
[BadRows, ~] = find(data(:, 11)<80 | data(:, 10)<60);
for i = 1: length(BadRows)
    labels(BadRows(i)) = 0;
end
data(:, [10, 11]) = [];

% ����ѵ��������Լ�
trainIndex = crossvalind('HoldOut', size(data,1), 0.25);    % ѵ��������
testIndex = ~trainIndex;                            % ���Լ�����
trainData = data(trainIndex, :);                    % ѵ��������
testData = data(testIndex, :);                      % ���Լ�����
trainLabel = labels(trainIndex);                    % ѵ������ǩ
testLabel = labels(testIndex);                      % ���Լ���ǩ

% ���ݹ�һ������Ҫת��
[~, PS] = mapminmax(trainData');
trainNorm = mapminmax('apply', trainData', PS);
testNorm = mapminmax('apply', testData', PS);

%% BP���������
%����BPǰ��������
net = newff(trainNorm,trainLabel',9,{'tansig','purelin'},'trainlm');
%�������������
net.trainParam.epochs = 200;  %ѵ����������
net.trainParam.goal = 0.01;  %ѵ��Ŀ������
net.trainParam.lr = 0.005;  %ѧϰ������
net.trainParam.mc = 0.9;  %�������ӵ�����
net.trainParam.max_fail = 20;  % ���ȷ��ʧ�ܴ���

%<--------------------------------��ʼѵ��-------------------------------->%

net = train(net,trainNorm,trainLabel');
trainPredict = sim(net,trainNorm);

trainPredict(trainPredict >= 0.5) = 1;
trainPredict(trainPredict < 0.5) = 0;
trainPredict = trainPredict';

% ��ͼ�鿴�������
plot(trainLabel, 'r-*')
hold on
plot(trainPredict, 'b:o')
legend('��ʵֵ', 'Ԥ��ֵ')
title('ѵ����Ԥ�����Ƚ�')

%% ���Լ�����
%���Լ���Ԥ�����
testPredict = sim(net,testNorm);
testPredict(testPredict >= 0.5) = 1;
testPredict(testPredict < 0.5) = 0;
testPredict = testPredict';

% ��ͼ�鿴�������
figure()
plot(testLabel, 'r-*')
hold on
plot(testPredict, 'b:o')
legend('��ʵֵ', 'Ԥ��ֵ')
title('���Լ�Ԥ�����Ƚ�')



% %% ֧������������
% % Ѱ�����c��g����
% [c,g] = meshgrid(-10:1:10,-10:1:10);
% [m,n] = size(c);
% cg = zeros(m,n);
% eps = 10^(-4);
% v = 5;
% bestc = 1;
% bestg = 0.1;
% bestacc = 0;
% for i = 1:m
%     for j = 1:n
%         cmd = ['-v ',num2str(v),' -t 2',' -c ',num2str(2^c(i,j)),' -g ',num2str(2^g(i,j))];
%         cg(i,j) = libsvmtrain(trainLabel,trainData,cmd);
%         if cg(i,j) > bestacc
%             bestacc = cg(i,j);
%             bestc = 2^c(i,j);
%             bestg = 2^g(i,j);
%         end        
%         if abs( cg(i,j)-bestacc )<=eps && bestc > 2^c(i,j)
%             bestacc = cg(i,j);
%             bestc = 2^c(i,j);
%             bestg = 2^g(i,j);
%         end               
%     end
% end
% 
% % ѵ��SVM
% cmd = [' -t 2',' -c ',num2str(bestc),' -g ',num2str(bestg)];
% model = libsvmtrain(trainLabel,trainData,cmd);
% 
% % ������
% [predict_label_1,accuracy_1,~] = libsvmpredict(trainLabel,trainData,model);
% [predict_label_2,accuracy_2,~] = libsvmpredict(testLabel,testLabel,model);
% result_1 = [trainLabel predict_label_1];
% result_2 = [testLabel predict_label_2];
% 
% % ��ͼ
% figure
% plot(1:length(testLabel),testLabel,'r-*')
% hold on
% plot(1:length(testLabel),predict_label_2,'b:o')
% grid on
% legend('��ʵ���','Ԥ�����')
% xlabel('���Լ��������')
% ylabel('���Լ��������')
% string = {'���Լ�SVMԤ�����Ա�(RBF�˺���)';
%           ['accuracy = ' num2str(accuracy_2(1)) '%']};
% title(string)


