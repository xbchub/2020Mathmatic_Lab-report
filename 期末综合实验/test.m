%%��ջ�������
clc
clear
close all

%%��������(��Ҫ�ֶ��������)
%%load data input ourput

%%��ȡinput���е�����
i=size(input,1);

%%�������
k=rand(1,i);
[m,n]=sort(k);

%%ѡ��ѵ�����ݺ�Ԥ������
input_train=input(n(1:i),:)';
output_train=output(n(1:i));
input_test=input(n(i-45:i),:)';
output_test=output(n(i-45:i));

%%���ݹ�һ��
[inputn,inputps]=mapminmax(input_train);
[outputn,outputps]=mapminmax(output_train);

%%BP������ѵ��
%%��ʼ������ṹ���������ز������ѧϰ��
net=newff(inputn,outputn,5);
net.trainParam.lr=0.01;
net.trainParam.goal=0.00004;
net.trainParam.show=50;
net.trainParam.max_fail=10;

%����ѵ��
net=train(net,inputn,outputn);

%% BP����Ԥ��
%Ԥ�����ݹ�һ��
inputn_test=mapminmax('apply',input_test,inputps);
 
%%BP����Ԥ�����
an=sim(net,inputn_test);

%�����������һ��
BPoutput=mapminmax('reverse',an,outputps);
plot([0,50],[-0.1,-0.1],'red')
%% �������
figure(1)
plot(BPoutput,':og');
hold on
plot(output_test,'-*');
legend('Ԥ�����','fontsize')
ylabel('�������','fontsize',12)
xlabel('����','fontsize',12)

%Ԥ�����
figure(2)
error=BPoutput-output_test;
plot(error,'-*')
title('BP����Ԥ�����','fontsize',12)
ylabel('���','fontsize',12)
xlabel('����','fontsize',12)

figure(3)
plot((output_test-BPoutput)./BPoutput,'-*')
hold on
plot([0,50],[0.1,0.1],'red');
hold on 
plot([0,50],[-0.1,-0.1],'red');
title('������Ԥ�����ٷֱ�')
%%����ƽ�����
errorsum = sum(abs((output_test-BPoutput)./BPoutput))/43