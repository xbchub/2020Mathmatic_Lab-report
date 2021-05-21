function X=flipall(X)
        for m=1:ndims(X)
            X=flipdim(X,m);
        end
    end
