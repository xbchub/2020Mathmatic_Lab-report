function [trainData, testData] = dataPreprocess(filename)
% ���ݵ�Ԥ���� 
% params filename ������ݵ�excel�ļ���
% return trainData ѵ��������
% return testData ���Լ�����
data = xlsread(filename);
[nanRows, ~] = find(isnan(data));           % �ҵ�����NaN����
data(nanRows, :) = [];                      % ɾ������NaN����
[zeroRows, ~] = find(data == 0);
data(zeroRows, :) = [];
% [CODRows, ~] = find(data(:, 9)<60);
% data(CODRows, :) = [];
% [VFARows, ~] = find(data(:, 10)<40);
% data(VFARows, :) = [];

string = ["OLR", "��ˮ��", "��ˮCOD", "HLR",...   % ���ݱ�ǩ
         "ALR", "pH", "�¶�", "TSS",...
         "��ˮVFA", "CODȥ����(%)", "VFAȥ����(%)"];

% ��ͼ�鿴ԭʼ���ݷֲ����
for j = 1: 11
    subplot(4, 3, j)
    plot(data(:, j))
    title(string(j))
end

% �޳�Ұ���ݣ���3sigma��������
miu = mean(data);         % ƽ��ֵ
sigma = std(data);        % ��׼��
for i = 1: size(data, 1)
    % 3sigma��������ݸ�ֵNaN
    for j = 1: size(data, 2)
        if (abs(data(i, j) - miu(j))) > 3 * sigma(j)
            data(i, j) = NaN;
        end
    end
end
[nanRows, ~] = find(isnan(data));           % �ҵ�����NaN����
data(nanRows, :) = [];                      % ɾ������NaN����

% ��ͼ�鿴Ԥ��������ݷֲ����
figure()
for j = 1: 11
    subplot(4, 3, j)
    plot(data(:, j))
    title(string(j))
end

% ����ѵ��������Լ�
trainIndex = crossvalind('HoldOut', size(data,1), 0.25);    % ѵ��������
testIndex = ~trainIndex;                            % ���Լ�����
trainData = data(trainIndex, :);                    % ѵ��������
testData = data(testIndex, :);                      % ���Լ�����
