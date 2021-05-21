%问题一代码：
y = dsolve('D2y-2*Dy+5*y=exp(x)*sin(2*x)','x')  %（1）问求解

y_ = dsolve('D2y=Dy+2*y','y(0)=1','Dy(0)=0','x')  %（2）问求解