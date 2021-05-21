function [trainData, testData] = dataPreprocess(filename)
% 数据的预处理 
% params filename 存放数据的excel文件名
% return trainData 训练集数据
% return testData 测试集数据
data = xlsread(filename);
[nanRows, ~] = find(isnan(data));           % 找到存在NaN的行
data(nanRows, :) = [];                      % 删除存在NaN的行
[zeroRows, ~] = find(data == 0);
data(zeroRows, :) = [];
% [CODRows, ~] = find(data(:, 9)<60);
% data(CODRows, :) = [];
% [VFARows, ~] = find(data(:, 10)<40);
% data(VFARows, :) = [];

string = ["OLR", "进水量", "进水COD", "HLR",...   % 数据标签
         "ALR", "pH", "温度", "TSS",...
         "进水VFA", "COD去除率(%)", "VFA去除率(%)"];

% 画图查看原始数据分布情况
for j = 1: 11
    subplot(4, 3, j)
    plot(data(:, j))
    title(string(j))
end

% 剔除野数据，即3sigma以外数据
miu = mean(data);         % 平均值
sigma = std(data);        % 标准差
for i = 1: size(data, 1)
    % 3sigma以外的数据赋值NaN
    for j = 1: size(data, 2)
        if (abs(data(i, j) - miu(j))) > 3 * sigma(j)
            data(i, j) = NaN;
        end
    end
end
[nanRows, ~] = find(isnan(data));           % 找到存在NaN的行
data(nanRows, :) = [];                      % 删除存在NaN的行

% 画图查看预处理后数据分布情况
figure()
for j = 1: 11
    subplot(4, 3, j)
    plot(data(:, j))
    title(string(j))
end

% 划分训练集与测试集
trainIndex = crossvalind('HoldOut', size(data,1), 0.25);    % 训练集索引
testIndex = ~trainIndex;                            % 测试集索引
trainData = data(trainIndex, :);                    % 训练集数据
testData = data(testIndex, :);                      % 测试集数据
