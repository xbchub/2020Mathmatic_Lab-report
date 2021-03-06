function case3(k) %显示迭代 k 次后的 Koch 曲线图
p1 = [0 0;10 0]; %存放结点坐标，每行一个点，初始值为两结点的坐标
p2 = [10 0;15 5*sqrt(3)];
p3 = [15 5*sqrt(3);10 10*sqrt(3)];
p4 = [10 10*sqrt(3);0 10*sqrt(3)];
p5 = [0 10*sqrt(3);-5 5*sqrt(3)];
p6 = [-5 5*sqrt(3);0 0];
n = 1; %存放线段的数量，初始值为 1
A = [cos(pi/3),-sin(pi/3);sin(pi/3),cos(pi/3)];
B = [cos(pi/3),sin(pi/3);-sin(pi/3),cos(pi/3)];  %角度偏移，用于计算新的结点
for a = 1:k  %实现迭代过程，计算所有的结点的坐标
    j = 0;   %以下根据线段两个结点的坐标，计算迭代后它们之间增加的三个
             %结点的坐标，并且将这些点的坐标按次序存暂时放到 r 中
    for i = 1:n  %每条边计算一次
        s1 = p1(i,:); s3 = p2(i,:); s5 = p3(i,:);
        s7 = p4(i,:); s9 = p5(i,:); s11 = p6(i,:);   %目前线段的起点坐标
        s2 = p1(i+1,:); s4 = p2(i+1,:); s6 = p3(i+1,:); 
        s8 = p4(i+1,:); s10 = p5(i+1,:); s12 = p6(i+1,:); %目前线段的终点坐标
        d1 = (s2-s1)/3; d2 = (s4-s3)/3; d3 = (s6-s5)/3; 
        d4 = (s8-s7)/3; d5 = (s10-s9)/3; d6 = (s12-s11)/3;
        j = j+1; 
        r1(j,:) = s1; r2(j,:) = s3; r3(j,:) = s5; 
        r4(j,:) = s7; r5(j,:) = s9; r6(j,:) = s11; %原起点存入 r
        j = j+1; 
        r1(j,:) = s1+d1; r2(j,:) = s3+d2; r3(j,:) = s5+d3; 
        r4(j,:) = s7+d4; r5(j,:) = s9+d5; r6(j,:) = s11+d6;  %新 1 点存入 r
        if (mod(i,7)==3)|(mod(i,7)==4)|(mod(i,7)==5)  %每次循环的第三、四、五条边迭代顺序与其它边相反
            j = j+1; 
            r1(j,:) = s1+d1+d1*B'; r2(j,:) = s3+d2+d2*B'; r3(j,:) = s5+d3+d3*B'; 
            r4(j,:) = s7+d4+d4*B'; r5(j,:) = s9+d5+d5*B'; r6(j,:) = s11+d6+d6*B'; %新 2 点存入 r
            j = j+1; 
            r1(j,:) = s1+d1+2*d1*B'; r2(j,:) = s3+d2+2*d2*B'; r3(j,:) = s5+d3+2*d3*B'; 
            r4(j,:) = s7+d4+2*d4*B'; r5(j,:) = s9+d5+2*d5*B'; r6(j,:) = s11+d6+2*d6*B'; %新 3 点存入 r
            j = j+1; 
            r1(j,:) = s1+2*d1*B'; r2(j,:) = s3+2*d2*B'; r3(j,:) = s5+2*d3*B'; 
            r4(j,:) = s7+2*d4*B'; r5(j,:) = s9+2*d5*B'; r6(j,:) = s11+2*d6*B'; %新 4 点存入 r
            j = j+1; 
            r1(j,:) = s1+d1+d1*B'; r2(j,:) = s3+d2+d2*B'; r3(j,:) = s5+d3+d3*B'; 
            r4(j,:) = s7+d4+d4*B'; r5(j,:) = s9+d5+d5*B'; r6(j,:) = s11+d6+d6*B'; %新 5 点存入 r
        else
            j = j+1; 
            r1(j,:) = s1+d1+d1*A'; r2(j,:) = s3+d2+d2*A'; r3(j,:) = s5+d3+d3*A'; 
            r4(j,:) = s7+d4+d4*A'; r5(j,:) = s9+d5+d5*A'; r6(j,:) = s11+d6+d6*A'; %新 2 点存入 r
            j = j+1; 
            r1(j,:) = s1+d1+2*d1*A'; r2(j,:) = s3+d2+2*d2*A'; r3(j,:) = s5+d3+2*d3*A'; 
            r4(j,:) = s7+d4+2*d4*A'; r5(j,:) = s9+d5+2*d5*A'; r6(j,:) = s11+d6+2*d6*A'; %新 3 点存入 r
            j = j+1; 
            r1(j,:) = s1+2*d1*A'; r2(j,:) = s3+2*d2*A'; r3(j,:) = s5+2*d3*A'; 
            r4(j,:) = s7+2*d4*A'; r5(j,:) = s9+2*d5*A'; r6(j,:) = s11+2*d6*A'; %新 4 点存入 r
            j = j+1; 
            r1(j,:) = s1+d1+d1*A'; r2(j,:) = s3+d2+d2*A'; r3(j,:) = s5+d3+d3*A'; 
            r4(j,:) = s7+d4+d4*A'; r5(j,:) = s9+d5+d5*A'; r6(j,:) = s11+d6+d6*A'; %新 5 点存入 r
        end
        j = j+1; 
        r1(j,:) = s1+2*d1; r2(j,:) = s3+2*d2; r3(j,:) = s5+2*d3; 
        r4(j,:) = s7+2*d4; r5(j,:) = s9+2*d5; r6(j,:) = s11+2*d6; %新 6 点存入 r
        
    end  %原终点作为下条线段的起点，在迭代下条线段时存入 r
    n=7*n;  %全部线段迭代一次后，线段数量乘 7
    clear p1 p2 p3 p4 p5 p6  %清空 p1 p2 p3 p4 p5 p6
	p1=[r1;s2]; p2=[r2;s4]; p3=[r3;s6];
    p4=[r4;s8]; p5=[r5;s10]; p6=[r6;s12];%重新装载本次迭代后的全部结点
end
hold on
plot(p1(:,1),p1(:,2),'b'); plot(p2(:,1),p2(:,2),'b'); plot(p3(:,1),p3(:,2),'b')
plot(p4(:,1),p4(:,2),'b'); plot(p5(:,1),p5(:,2),'b'); plot(p6(:,1),p6(:,2),'b')%显示各结点的连线图
hold off
axis equal  %各坐标轴同比例