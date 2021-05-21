clear,clc
x=100:100:500;
y=100:100:400;
z=[636 697 624 478 450
698 712 630 478 420
680 674 598 412 400
662 626 552 334 310];
pp=csape({x,y},z')
xi=100:10:500;yi=100:10:400
cz1=fnval(pp,{xi,yi})
cz2=interp2(x,y,z,xi,yi','spline')
[i,j]=find(cz1==max(max(cz1)))
x=xi(i),y=yi(j),zmax=cz1(i,j)

[k,l]=find(cz2==max(max(cz2)))
x1=xi(k),y1=yi(l),zmax=cz1(k,l)