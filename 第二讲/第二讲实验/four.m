n = 10;  
a = sym('a',[n,1]);  
b = sym('b',[1,n]);  
A = a*b  
disp('1)�ʣ�')  
rank(A) == 1 %�ж�A�����Ƿ�Ϊ1  
disp('2)�ʣ�')  
syms k;
[k] = solve([A*A == A*k],[k])
