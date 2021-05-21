 function X = rot180(X)  
        X = flipdim(flipdim(X, 1), 2);  
    end 
