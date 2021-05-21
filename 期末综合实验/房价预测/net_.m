% ========================================================================
% 华南理工大学电子与信息学院18级本科生许柏城
% ========================================================================
% 
% 功能：
% 1.根据各城市连续月分布的房价价格指数对下一月房价进行预测
% 2.针对最新房价和三年来的房价涨幅对城市进行分类，并导入excel进行下一步分析

% 数据来源：
% 1.国家统计局
% 2.中国房价行情网（爬虫爬取）

% 作者：许柏城   时间：2020-05-23
% 文件名：Hosue_price_net
% 平台：MATLAB R2018a
% 版本：V2.0
clc
clear all
%% 预处理数据
%导入xls文件，其中num为56*36
%行：56个城市；列：2017.5-2020.3 35个月份新建商品住宅销售价格指数（上月=100）+2017.5的房价
[num,txt] = xlsread('主要城市房价月度价格.xls');
%将数据大小用变量表示，以便代码具有更好的可用性和维护性
[city,month] = size(num);
%36列数据中，最后一列是2017.5的真实房价，不是每月风的价格指数，因此重定义month大小
month = month-1;
%对35个月份的价格指数/100，转化为相对价格浮动指数
num(:,1:month) = num(:,1:month)/100;

%根据房价和上一行求得的相对价格浮动指数计算各月的实际房价,并存入37-71列
for i = 1:month
    num(:,month+1+i) = num(:,month+i).*num(:,i);
end

%% 功能一：根据前三个月房价预测后一个月房价和相对涨幅(BP前馈神经网络)
%对价格指数按行归一化，定义最值以便后面反归一化
max = max(num(:,1:month));
min = min(num(:,1:month));
num(:,1:month) = mapminmax(num(:,1:month),0,1)

%预分配神经网络输入向量的空间，三维矩阵，某连续三月价格指数*所有的连续三月*某城市
num_predict = zeros(3,month-2,city);
%预分配神经网络输入向量的空间，三维矩阵，某连续三月后一月的价格指数*所有的连续三月*某城市
num_goal = zeros(1,month-2,city);
num_ = num';

%定义BP神经网络
net_predict = newff([0 1;0 1;0 1],[5,1],{'tansig','logsig'},'traingd');
%网络参数的设置
net_predict.trainParam.epochs = 20000;  %训练次数设置
net_predict.trainParam.goal = 0.01;  %训练目标设置
net_predict.trainParam.lr = 0.05;  %学习率设置 
net_predict.trainParam.mc = 0.9;  %动量因子的设置

%对56个城市逐一训练符合各自情况的神经网络，并将预测结果输出
for i = 1:city
    for j = 1:month-3
        %定义i城市的输入向量，三维矩阵，j到j+2月的价格指数*所有的连续三月情况（j取1到month-2）*i城市
        num_predict(:,j,i) = num_(j:j+2,i);
        %定义i城市的目标向量，三维矩阵，j+3月的目标价格指数*所有的连续三月情况（j取1到month-2）*i城市
        num_goal(:,j,i) = num_(j+3,i);
    end
    
%<--------------------------------开始训练-------------------------------->%

    net_predict = train(net_predict,num_predict(:,:,i),num_goal(:,:,i));
    %在第72列导入2020年4月份房价涨幅的预测值(并将其反归一化)
    num(i,2*month+2) = sim(net_predict,num_predict(:,month-2,i));  %预测值
    num(i,2*month+2) = min(1,i)+(max(1,i)-min(1,i))*num(i,2*month+2);  %反归一化后的预测值
    %在第73列导入2020年4月份房价预测值
    num(i,2*month+3) = num(i,2*month+1)*num(i,2*month+2);
    disp(['2020年4月份 ',txt(i+1,1),'的房价是：',num2str(num(i,2*month+1))])
end

%% 功能二：根据三年的房价涨幅和最新房价两个参数对地区进行分类（自组织SOM神经网络）
%导入第一个特征向量：2020.3各城市房价
som(1,:) = num(:,2*month+1)';
som(1,:) = mapminmax(som(1,:),0,1);

%导入第二个特征向量：2017.5到2020.3的房价涨幅
som(2,:) = num(:,2*month+1)'./num(month+1)';
som(2,:) = mapminmax(som(2,:),0,1);

%建立som网络
net_class = newsom(som,[2 4]);
net_class.trainParam.epochs = 1000;

%<--------------------------------开始训练-------------------------------->%
net_class = train(net_class,som);
%输出SOM神经网络分类结果
t_sim_compet_1 = sim(net_class,som);
%用线性数值表示，选出最后胜利的神经元
T_sim_compet_1 = vec2ind(t_sim_compet_1);
%神经元分类结果（输出结果与城市字符数组拼接）
result_compet_1 = strcat(txt(2:city+1,1),num2str(T_sim_compet_1'))
% %建立竞争神经网络(备选分类网络)
% net_class = newc(som,4,0.01,0.01);
% net_class.trainParam.epochs = 1000;
% % w=net.iw(1,1);
% net_class = train(net_class,som);
% t_sim_compet_2 = sim(net_class,som);
% T_sim_compet_2 = vec2ind(t_sim_compet_2);
% result_compet_2 = strcat(txt(2:city+1,1),num2str(T_sim_compet_2'))