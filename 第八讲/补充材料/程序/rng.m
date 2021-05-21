rng(sd) seeds the random number generator using the nonnegative integer
rng需要非负整数.如果要用本次生成做种子,要保证必须大于1,否则每次都是0
s = rng; % 初始化
states = cell(1,10);  % 保存10次state
for i=1:10
    x = randi(10,1,1);  % 生成小于10的整型随机数
    s = rng(x); % 用当前生成的随机数做下一次的种子
    states{i} = s.State; % 保存状态
end
libralibra (站内联系TA)
不想改seed就把循环体重的s=rng(x)去掉啊
ldoop (站内联系TA)
3楼: Originally posted by libralibra at 2012-04-13 02:54:47:
不想改seed就把循环体重的s=rng(x)去掉啊 
s = rng; % 初始化
states = cell(1,10);  % 保存10次state
for i=1:10
    x = randi(10,1,1);  % 生成小于10的整型随机数
    states{i} = s.State; % 保存状态
end
这样得到的states值都是一样的
我想实现的是
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
也就是运行完一个，保存当前的的state，作为下个rng的初始state，不知道如何操作？
其实程序和下面的程序等价
rng（1）；
for i=1:10
a=rand;
b=rand;...
end
只是想控制每一步产生的随机数。当然另外一种方法是，提前生成一个随机数序列，但是想知道这种方法是否能实现
