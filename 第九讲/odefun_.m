function dm = odefun_(t,m)
    dm = zeros(3,1);
    dm(1) = m(1)*(1-m(1)-m(2)-6*m(3))
    dm(2) = m(2)*(1.5*m(1)-m(2)-m(3))
    dm(3) = m(3)*(-1+3*m(1)+0.5)