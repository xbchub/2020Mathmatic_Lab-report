function [error, R] = errorAnalysis(predict, output)
% ���ڼ���Ԥ����������ʵ���ݵ����
% params predict Ԥ��ֵ
% params output ʵ��ֵ
% return errorAvg ƽ����ԽСԽ׼ȷ
% return R2 ���ϵ����Խ��Խ׼ȷ
CODPredict = predict(1, :);     % CODԤ������
VFAPredict = predict(2, :);     % VFAԤ������
CODOutput = output(1, :);       % COD��ʵ����
VFAOutput = output(2, :);       % VFA��ʵ����

% �������
columns = size(output,2);
error1 = (CODPredict - CODOutput)./CODOutput;  % COD���
error1Mean = mean(abs(error1));                              % CODƽ�����
error2 = (VFAPredict - VFAOutput)./VFAOutput;  % VFA���
error2Mean = mean(abs(error2));                              % VFAƽ�����
error = [error1Mean, error2Mean];

% �������ϵ��R^2��R^2Խ�ӽ�1��ʾ���Խ��
R1 = solveR(CODPredict, CODOutput, columns);
R2 = solveR(VFAPredict, VFAOutput, columns);
R = [R1, R2];

%  ����CODԤ��ֵ����ʵֵ
figure()
subplot(121)
plot(CODOutput ,'x')
hold on
plot( CODPredict, 'o')
axis([0 columns 0 100])
legend('��ʵֵ','Ԥ��ֵ')
xlabel('����')
ylabel('CODȥ����')
string = {'���Լ���ˮCODȥ����Ԥ�����Ա�'; ['R^2=', num2str(R1)]};
title(string)

% ����VFAԤ��ֵ����ʵֵ
subplot(122)
plot(VFAOutput ,'x')
hold on
plot( VFAPredict, 'o')
axis([0 columns 0 100])
legend('��ʵֵ','Ԥ��ֵ')
xlabel('����')
ylabel('VFAȥ����')
string = {'���Լ���ˮVFAȥ����Ԥ�����Ա�'; ['R^2=', num2str(R2)]};
title(string)

% error
figure()
subplot(121)
plot(abs(error1), '.')
axis([0 350 0 0.5])
xlabel('����')
ylabel('������')
title('CODȥ�������')
grid on

subplot(122)
plot(abs(error2), '.')
axis([0 350 0 0.5])
xlabel('����')
ylabel('������')
title('VFAȥ�������')
grid on

function R = solveR(predict, output, number)
% solveR ���ڼ������ϵ��R^2
% params predict Ԥ��ֵ��Ϊ��������������
% params output ��ʵֵ��Ϊ��������������
% params number ���ϵ��R^2
R = (number * sum(predict .* output) - sum(predict) * sum(output))^2 / ...
((number * sum(predict.^2) - (sum(predict))^2) * ...
(number * sum(output.^2) - (sum(output))^2));




