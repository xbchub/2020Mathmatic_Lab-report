rng(sd) seeds the random number generator using the nonnegative integer
rng��Ҫ�Ǹ�����.���Ҫ�ñ�������������,Ҫ��֤�������1,����ÿ�ζ���0
s = rng; % ��ʼ��
states = cell(1,10);  % ����10��state
for i=1:10
    x = randi(10,1,1);  % ����С��10�����������
    s = rng(x); % �õ�ǰ���ɵ����������һ�ε�����
    states{i} = s.State; % ����״̬
end
libralibra (վ����ϵTA)
�����seed�Ͱ�ѭ�����ص�s=rng(x)ȥ����
ldoop (վ����ϵTA)
3¥: Originally posted by libralibra at 2012-04-13 02:54:47:
�����seed�Ͱ�ѭ�����ص�s=rng(x)ȥ���� 
s = rng; % ��ʼ��
states = cell(1,10);  % ����10��state
for i=1:10
    x = randi(10,1,1);  % ����С��10�����������
    states{i} = s.State; % ����״̬
end
�����õ���statesֵ����һ����
����ʵ�ֵ���
for i=1:10
if i==1
rng(1);
else
load the state
use the state as the initial state
end
a=rand;
b=rand;...
save the current state
end
Ҳ����������һ�������浱ǰ�ĵ�state����Ϊ�¸�rng�ĳ�ʼstate����֪����β�����
��ʵ���������ĳ���ȼ�
rng��1����
for i=1:10
a=rand;
b=rand;...
end
ֻ�������ÿһ�����������������Ȼ����һ�ַ����ǣ���ǰ����һ����������У�������֪�����ַ����Ƿ���ʵ��
