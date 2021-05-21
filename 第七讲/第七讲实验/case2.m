n = 2;
original = [0;1i];  %0,i
rotation = [exp(1i*pi/6),exp(-1i*pi/6)];

plot(original) %画出主图
pause(3)
hold on
for s = 1: n
    j = 0;
    [~, len] = size(original)  %忽略行数只取列数
    for k = 1: len
        low_ = original(1, k);
        high_ = original(2, k);
        d = (high_ - low_) / 3;
        
        frat(1, j+1) = low_ + d;
        frat(2, j+1) = low_ + d + d*rotation(1);
        frat(1, j+2) = low_ + 2*d;
        frat(2, j+2) = low_ + 2*d + d*rotation(2);
        j = j + 2;
        new = frat;
        new(1, j+1) = low_ + 2*d;
        new(2, j+1) = high_;
    end
    plot(frat)
    original = new;
end
hold off
axis equal