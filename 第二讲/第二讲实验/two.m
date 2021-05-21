m = 3; n = 4;  
Em = eye(m, m);  
En = eye(n, n);  
A = sym('a', [n, m]);  
B = sym('b', [m, n]);  
M1 = [Em, B; A, En]  
M2 = En - A*B  
M3 = Em - B*A  
if det(M1) == det(M2) & det(M1)==det(M3)  
    disp('M1=M2=M3,µÃÖ¤')  
end  
