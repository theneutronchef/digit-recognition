function [input] = binarize(input, x, y)

    for i=1:x*y
        if input(i) > 95
            input(i) = -1;
        else 
            input(i) = 1;
        end
    end
    
