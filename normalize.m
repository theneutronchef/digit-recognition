function [input] = normalize(input, x, y)

    total_count = sum(sum(input));
    for i=1:x*y
        input(i) = input(i) / total_count;
    end
    
