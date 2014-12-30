function [result] = dot_product(A, B, x, y)
    
    result = 0;
    for i=1:x
        for j=1:y
            result = result + A(i, j) * B(i, j);
        end
    end
