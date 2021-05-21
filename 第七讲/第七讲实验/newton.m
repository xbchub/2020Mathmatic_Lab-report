function y=newton(z)
if (z==0)
    y=0;
    return;
end
for i=1:1:2000
    y=z-(z^3-1)/(3*z^2);
    if (abs(y-z)<1.0e-7)
        break;
    end
    z=y;
end