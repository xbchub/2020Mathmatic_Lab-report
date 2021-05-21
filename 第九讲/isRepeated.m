function [repeated]=isRepeated(element,vectToCheck,row)
[N,M]=size(vectToCheck);

d=0;
for v=1:M
    if element==vectToCheck(row,v);
        d=1;
    end
end

if d==0
    repeated=0;
end

if d==1
    repeated=1;
end