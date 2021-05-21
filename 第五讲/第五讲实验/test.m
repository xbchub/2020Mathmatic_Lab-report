m=26;
A=[21,18;3,19];
det_A=mod(det(A),m);
inv_det_A = 15;
 for i=1:m
    if round(mod(det_A*i,m))==1
        inv_det_A=i;
    end
 end
inv_A=inv(A)*det(A);
inv_A_mod=mod(inv_det_A*inv_A,m);