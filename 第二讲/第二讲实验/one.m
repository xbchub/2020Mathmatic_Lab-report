n=10;

% ´´½¨¾ØÕó
for i = 1:n-1
    A(i, i+1) = sym(['a', num2str(i)]);
end
A(n, 1) = sym(['a', num2str(n)]);
inv(A)
