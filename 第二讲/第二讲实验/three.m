n=3;
A = sym('a',[n,n])
B = sym('b',[n,n])
C = sym('c',[n,n])
D = sym('d',[n,n])
C_=inv(A)*C*A;  %换元法，已知C=inv(A)*C*A，这里将C的值用C_表示，代入下面式子
left_=det([A,B;C_,D])  %换元，这里C_=inv(A)*C*A
right_ = det([A*D-C*B])
if left_ == right_ %判断
    disp('得证')
end
