function yi= itp1(x,y,xi)
vx= vander(x);  %产生范德蒙矩阵
ai= inv(vx)*y;  %解方程组
yi= polyval(ai, xi); 
