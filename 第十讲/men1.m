%2���ʴ��룺
function fm = men1(n)
x2 = unifrnd(10,20,1,n);  %����(����)���ȷֲ��������
x1 = x2+10;
x3 = unifrnd(-5,16,1,n);
f = zeros(1,n);
for i = 1: n  %n��ѭ��
    if -x1(i)+2*x2(i)+2*x3(i)>=0 && x1(i)+2*x2(i)+2*x3(i)<=72  %���㲻��ʽ
        f(i) = x1(i)*x2(i)*x3(i);
    end
end
fm = max(f);  %�����ֵ
plot(f, '.')
title('2����ͼ��')
