n=3;
A = sym('a',[n,n])
B = sym('b',[n,n])
C = sym('c',[n,n])
D = sym('d',[n,n])
C_=inv(A)*C*A;  %��Ԫ������֪C=inv(A)*C*A�����ｫC��ֵ��C_��ʾ����������ʽ��
left_=det([A,B;C_,D])  %��Ԫ������C_=inv(A)*C*A
right_ = det([A*D-C*B])
if left_ == right_ %�ж�
    disp('��֤')
end
