%% 数据处理
filename = "data.xlsx";
data = xlsread(filename);
[nanRows, ~] = find(isnan(data));           % 找到存在NaN的行
data(nanRows, :) = [];                      % 删除存在NaN的行
[zeroRows, ~] = find(data == 0);
data(zeroRows, :) = [];

% 得到异常与正常样本的标签
labels = ones(size(data, 1));
[BadRows, ~] = find(data(:, 11)<80 | data(:, 10)<60);
for i = 1: length(BadRows)
    labels(BadRows(i)) = 0;
end
data(:, [10, 11]) = [];

% 划分训练集与测试集
trainIndex = crossvalind('HoldOut', size(data,1), 0.25);    % 训练集索引
testIndex = ~trainIndex;                            % 测试集索引
trainData = data(trainIndex, :);                    % 训练集数据
testData = data(testIndex, :);                      % 测试集数据
trainLabel = labels(trainIndex);                    % 训练集标签
testLabel = labels(testIndex);                      % 测试集标签

% 数据归一化，需要转置
[~, PS] = mapminmax(trainData');
trainNorm = mapminmax('apply', trainData', PS);
testNorm = mapminmax('apply', testData', PS);

%% BP神经网络分类
%定义BP前馈神经网络
net = newff(trainNorm,trainLabel',9,{'tansig','purelin'},'trainlm');
%网络参数的设置
net.trainParam.epochs = 200;  %训练次数设置
net.trainParam.goal = 0.01;  %训练目标设置
net.trainParam.lr = 0.005;  %学习率设置
net.trainParam.mc = 0.9;  %动量因子的设置
net.trainParam.max_fail = 20;  % 最大确认失败次数

%<--------------------------------开始训练-------------------------------->%

net = train(net,trainNorm,trainLabel');
trainPredict = sim(net,trainNorm);

trainPredict(trainPredict >= 0.5) = 1;
trainPredict(trainPredict < 0.5) = 0;
trainPredict = trainPredict';

% 画图查看分类情况
plot(trainLabel, 'r-*')
hold on
plot(trainPredict, 'b:o')
legend('真实值', '预测值')
title('训练集预测结果比较')

%% 测试集测试
%测试集的预测输出
testPredict = sim(net,testNorm);
testPredict(testPredict >= 0.5) = 1;
testPredict(testPredict < 0.5) = 0;
testPredict = testPredict';

% 画图查看分类情况
figure()
plot(testLabel, 'r-*')
hold on
plot(testPredict, 'b:o')
legend('真实值', '预测值')
title('测试集预测结果比较')



% %% 支持向量机分类
% % 寻找最佳c、g函数
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
% % 训练SVM
% cmd = [' -t 2',' -c ',num2str(bestc),' -g ',num2str(bestg)];
% model = libsvmtrain(trainLabel,trainData,cmd);
% 
% % 分类结果
% [predict_label_1,accuracy_1,~] = libsvmpredict(trainLabel,trainData,model);
% [predict_label_2,accuracy_2,~] = libsvmpredict(testLabel,testLabel,model);
% result_1 = [trainLabel predict_label_1];
% result_2 = [testLabel predict_label_2];
% 
% % 绘图
% figure
% plot(1:length(testLabel),testLabel,'r-*')
% hold on
% plot(1:length(testLabel),predict_label_2,'b:o')
% grid on
% legend('真实类别','预测类别')
% xlabel('测试集样本编号')
% ylabel('测试集样本类别')
% string = {'测试集SVM预测结果对比(RBF核函数)';
%           ['accuracy = ' num2str(accuracy_2(1)) '%']};
% title(string)


