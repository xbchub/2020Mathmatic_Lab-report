function [error, R] = errorAnalysis(predict, output)
% 用于计算预测数据与真实数据的误差
% params predict 预测值
% params output 实际值
% return errorAvg 平均误差，越小越准确
% return R2 相关系数，越大越准确
CODPredict = predict(1, :);     % COD预测数据
VFAPredict = predict(2, :);     % VFA预测数据
CODOutput = output(1, :);       % COD真实数据
VFAOutput = output(2, :);       % VFA真实数据

% 计算误差
columns = size(output,2);
error1 = (CODPredict - CODOutput)./CODOutput;  % COD误差
error1Mean = mean(abs(error1));                              % COD平均误差
error2 = (VFAPredict - VFAOutput)./VFAOutput;  % VFA误差
error2Mean = mean(abs(error2));                              % VFA平均误差
error = [error1Mean, error2Mean];

% 计算决定系数R^2，R^2越接近1表示拟合越好
R1 = solveR(CODPredict, CODOutput, columns);
R2 = solveR(VFAPredict, VFAOutput, columns);
R = [R1, R2];

%  绘制COD预测值与真实值
figure()
subplot(121)
plot(CODOutput ,'x')
hold on
plot( CODPredict, 'o')
axis([0 columns 0 100])
legend('真实值','预测值')
xlabel('样本')
ylabel('COD去除率')
string = {'测试集出水COD去除率预测结果对比'; ['R^2=', num2str(R1)]};
title(string)

% 绘制VFA预测值与真实值
subplot(122)
plot(VFAOutput ,'x')
hold on
plot( VFAPredict, 'o')
axis([0 columns 0 100])
legend('真实值','预测值')
xlabel('样本')
ylabel('VFA去除率')
string = {'测试集出水VFA去除率预测结果对比'; ['R^2=', num2str(R2)]};
title(string)

% error
figure()
subplot(121)
plot(abs(error1), '.')
axis([0 350 0 0.5])
xlabel('样本')
ylabel('相对误差')
title('COD去除率误差')
grid on

subplot(122)
plot(abs(error2), '.')
axis([0 350 0 0.5])
xlabel('样本')
ylabel('相对误差')
title('VFA去除率误差')
grid on

function R = solveR(predict, output, number)
% solveR 用于计算相关系数R^2
% params predict 预测值，为行向量或列向量
% params output 真实值，为行向量或列向量
% params number 相关系数R^2
R = (number * sum(predict .* output) - sum(predict) * sum(output))^2 / ...
((number * sum(predict.^2) - (sum(predict))^2) * ...
(number * sum(output.^2) - (sum(output))^2));




