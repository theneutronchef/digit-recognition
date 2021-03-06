function [percentage] = nearest_average()

    digits = cell(10, 1);
    training_sets = cell(10, 1);
    results = zeros(10, 1);
    hits = 0;
    num_inputs = 100;
    image_size = 28;

    for i=1:10
        filename = strcat('data', int2str(mod(i,10)));
        [digits{i}, training_sets{i}] = open_file(filename);
    end
    
    for i=1:10
        for j=1:num_inputs
            input = training_sets{i}{j};
            for k=1:10
                diff = input - digits{k};
                results(k) = dot_product(diff, diff, 28, 28);
            end
            [max_val, answer] = min(results);
            if answer == i
                hits = hits + 1;
            end
        end
    end
    
    percentage = hits / (10 * num_inputs)
        