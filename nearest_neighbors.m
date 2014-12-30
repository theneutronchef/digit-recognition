function [percentage] = nearest_neighbors()

    digits = cell(10, 1);
    training_sets = cell(10, 1);
    results = zeros(10, 1);
    hits = 0;
    num_inputs = 100;
    image_size = 28;

    for i=1:10
        filename = strcat('data', int2str(mod(i,10)));
        [training_sets{i}, digits{i}] = open_file2(filename);
    end
    
    for i=1:10
        for j=1:num_inputs
            input = training_sets{i}{j};
            results = zeros(5000, 1);
            min_diff = inf;
            for l=1:10
                for k=1:500
                    diff = input - digits{l}{k};                    
                    diff = dot_product(diff, diff, 28, 28);
                end
            end
            if answer == i
                hits = hits + 1;
            end
        end
    end
    
    percentage = hits / (10 * num_inputs)    