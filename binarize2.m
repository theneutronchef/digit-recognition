function [input] = binarize2(input, x, y)

    for i=1:x*y
        if input(i) > 120
            input(i) = 1;
        else 
            input(i) = 0;
        end
    end
    
