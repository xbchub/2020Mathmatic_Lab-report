%问题二代码
clc
clear all
%将密文数字编码为密文矩阵C
C = [15 23 9 23 26 24 21 9 5 2 21 18 9 12 8 1 13 13 10 20 14;
    10 16 19 21 21 1 21 19 1 1 3 19 16 2 1 13 12 10 15 5 8];
m = 26;  %模为26
%%若四个字母UCRS代表TACO
result1 = [21 18;  %若四个字母UCRS代表TACO
    3 19];
result2 = [15 23;
    10 16];
test1 = [20 3;  %测试字母TACO
    1 15];
mod_det_result1 = mod(det(result1),m);  %求det(C)(mod26)
for i=1:m  %求inv_det(C)(mod26)
    if round(mod(i*m+1,mod_det_result1)) == 0  %需要round函数转化为整数
        imod_det_result1 = (i*m+1)/mod_det_result1;
    end
end
try  %用try catch检查是否存在imod_det_result1，不存在即赋值0
    imod_det_result1
catch
    imod_det_result1 =0
end
inv_K = test1*imod_det_result1*det(result1)*mod(inv(result1),m)  %inv_K = M*inv_C(mod26)

disp('解密后明文为：')
M_ = mod(inv_K*C,26) %解密密文

%%若四个字母OJWP代表TACO
mod_det_result2 = mod(det(result2),m);  %求det(C)(mod26)
for i=1:m  %求inv_det(C)(mod26)
    if round(mod(i*m+1,mod_det_result2)) == 0  %需要round函数转化为整数
        imod_det_result2 = (i*m+1)/mod_det_result2;
    end
end
try   %用try catch检查是否存在imod_det_result2，不存在即赋值0
    imod_det_result2
catch
    imod_det_result2 =0
end
inv_K2 = test1*imod_det_result2*det(result2)*mod(inv(result2),m)  %inv_K2 = M*inv_C(mod26)

disp('解密后明文为：')
M_2 = mod(inv_K2*C,26) %解密密文