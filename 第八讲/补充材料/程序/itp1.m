function yi= itp1(x,y,xi)
vx= vander(x);  %���������ɾ���
ai= inv(vx)*y;  %�ⷽ����
yi= polyval(ai, xi); 
