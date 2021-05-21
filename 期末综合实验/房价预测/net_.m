% ========================================================================
% ��������ѧ��������ϢѧԺ18����������س�
% ========================================================================
% 
% ���ܣ�
% 1.���ݸ����������·ֲ��ķ��ۼ۸�ָ������һ�·��۽���Ԥ��
% 2.������·��ۺ��������ķ����Ƿ��Գ��н��з��࣬������excel������һ������

% ������Դ��
% 1.����ͳ�ƾ�
% 2.�й�������������������ȡ��

% ���ߣ���س�   ʱ�䣺2020-05-23
% �ļ�����Hosue_price_net
% ƽ̨��MATLAB R2018a
% �汾��V2.0
clc
clear all
%% Ԥ��������
%����xls�ļ�������numΪ56*36
%�У�56�����У��У�2017.5-2020.3 35���·��½���Ʒסլ���ۼ۸�ָ��������=100��+2017.5�ķ���
[num,txt] = xlsread('��Ҫ���з����¶ȼ۸�.xls');
%�����ݴ�С�ñ�����ʾ���Ա������и��õĿ����Ժ�ά����
[city,month] = size(num);
%36�������У����һ����2017.5����ʵ���ۣ�����ÿ�·�ļ۸�ָ��������ض���month��С
month = month-1;
%��35���·ݵļ۸�ָ��/100��ת��Ϊ��Լ۸񸡶�ָ��
num(:,1:month) = num(:,1:month)/100;

%���ݷ��ۺ���һ����õ���Լ۸񸡶�ָ��������µ�ʵ�ʷ���,������37-71��
for i = 1:month
    num(:,month+1+i) = num(:,month+i).*num(:,i);
end

%% ����һ������ǰ�����·���Ԥ���һ���·��ۺ�����Ƿ�(BPǰ��������)
%�Լ۸�ָ�����й�һ����������ֵ�Ա���淴��һ��
max = max(num(:,1:month));
min = min(num(:,1:month));
num(:,1:month) = mapminmax(num(:,1:month),0,1)

%Ԥ�������������������Ŀռ䣬��ά����ĳ�������¼۸�ָ��*���е���������*ĳ����
num_predict = zeros(3,month-2,city);
%Ԥ�������������������Ŀռ䣬��ά����ĳ�������º�һ�µļ۸�ָ��*���е���������*ĳ����
num_goal = zeros(1,month-2,city);
num_ = num';

%����BP������
net_predict = newff([0 1;0 1;0 1],[5,1],{'tansig','logsig'},'traingd');
%�������������
net_predict.trainParam.epochs = 20000;  %ѵ����������
net_predict.trainParam.goal = 0.01;  %ѵ��Ŀ������
net_predict.trainParam.lr = 0.05;  %ѧϰ������ 
net_predict.trainParam.mc = 0.9;  %�������ӵ�����

%��56��������һѵ�����ϸ�������������磬����Ԥ�������
for i = 1:city
    for j = 1:month-3
        %����i���е�������������ά����j��j+2�µļ۸�ָ��*���е��������������jȡ1��month-2��*i����
        num_predict(:,j,i) = num_(j:j+2,i);
        %����i���е�Ŀ����������ά����j+3�µ�Ŀ��۸�ָ��*���е��������������jȡ1��month-2��*i����
        num_goal(:,j,i) = num_(j+3,i);
    end
    
%<--------------------------------��ʼѵ��-------------------------------->%

    net_predict = train(net_predict,num_predict(:,:,i),num_goal(:,:,i));
    %�ڵ�72�е���2020��4�·ݷ����Ƿ���Ԥ��ֵ(�����䷴��һ��)
    num(i,2*month+2) = sim(net_predict,num_predict(:,month-2,i));  %Ԥ��ֵ
    num(i,2*month+2) = min(1,i)+(max(1,i)-min(1,i))*num(i,2*month+2);  %����һ�����Ԥ��ֵ
    %�ڵ�73�е���2020��4�·ݷ���Ԥ��ֵ
    num(i,2*month+3) = num(i,2*month+1)*num(i,2*month+2);
    disp(['2020��4�·� ',txt(i+1,1),'�ķ����ǣ�',num2str(num(i,2*month+1))])
end

%% ���ܶ�����������ķ����Ƿ������·������������Ե������з��ࣨ����֯SOM�����磩
%�����һ������������2020.3�����з���
som(1,:) = num(:,2*month+1)';
som(1,:) = mapminmax(som(1,:),0,1);

%����ڶ�������������2017.5��2020.3�ķ����Ƿ�
som(2,:) = num(:,2*month+1)'./num(month+1)';
som(2,:) = mapminmax(som(2,:),0,1);

%����som����
net_class = newsom(som,[2 4]);
net_class.trainParam.epochs = 1000;

%<--------------------------------��ʼѵ��-------------------------------->%
net_class = train(net_class,som);
%���SOM�����������
t_sim_compet_1 = sim(net_class,som);
%��������ֵ��ʾ��ѡ�����ʤ������Ԫ
T_sim_compet_1 = vec2ind(t_sim_compet_1);
%��Ԫ��������������������ַ�����ƴ�ӣ�
result_compet_1 = strcat(txt(2:city+1,1),num2str(T_sim_compet_1'))
% %��������������(��ѡ��������)
% net_class = newc(som,4,0.01,0.01);
% net_class.trainParam.epochs = 1000;
% % w=net.iw(1,1);
% net_class = train(net_class,som);
% t_sim_compet_2 = sim(net_class,som);
% T_sim_compet_2 = vec2ind(t_sim_compet_2);
% result_compet_2 = strcat(txt(2:city+1,1),num2str(T_sim_compet_2'))