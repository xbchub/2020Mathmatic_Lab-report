%%分形树木
function [z,A]= frat3(z,A,n);
N=6;	% 最大迭代次数
s=0.7;
Br=[pi/10;-pi/10]; % 偏转角
if n>N	% 超出迭代次数
    return
end
k=1;
if n==1;	% 第 1 次，画主干
    plot([z,z+exp(i*A)],'linewidth',3/N*(N-n+1));
%     pause(1) 
    hold on
    z=z+exp(i*A);
    [z,A]= frat3(z,A,n+1);
else
    while k<3
        A=A+Br(k);
        leng=s^(n-1);  
        plot([z,z+leng*exp(i*A)],'linewidth',3/N*(N-n+1));  %[z,z+leng*exp(i*A)]画图
%         pause(1)
        z=z+leng*exp(i*A);
        [z,A]= frat3(z,A,n+1);
        A=A+pi;
        z=z+leng*exp(i*A); A=A+pi-Br(k); k=k+1;
    end
end