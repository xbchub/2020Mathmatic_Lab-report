%%代码 
clc
a1 = [10 50 30]';  %各种食物单位质量营养
a2 = [20 40 10]';
a3 = [20 10 40]';
y = [100 300 200]';
A = [a1 a2 a3]';
rank([a1 a2 a3])  %求解秩

%%秩为3，所以有唯一解
x = A\y