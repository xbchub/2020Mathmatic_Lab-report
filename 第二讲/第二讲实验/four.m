n = 10;  
a = sym('a',[n,1]);  
b = sym('b',[1,n]);  
A = a*b  
disp('1)问：')  
rank(A) == 1 %判断A的秩是否为1  
disp('2)问：')  
syms k;
[k] = solve([A*A == A*k],[k])
