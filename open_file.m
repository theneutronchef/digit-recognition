function[ave, test_set] = open_file(filename)

    set_size = 1000;
    training_set_size = 900;
    image_size = 28;

    fid=fopen(filename,'r');
    test_set=cell(100, 1);

    ave = zeros(image_size, image_size);

    for i=1:set_size 
        m = fread(fid,[image_size image_size],'uint8');  
        
        if i > training_set_size
%             test_set{i-training_set_size} = normalize(binarize(rot90(m), 28, 28), 28, 28);
            test_set{i-training_set_size} = rot90(m);

        else
            ave = ave + rot90(m);
        end

    end 

    ave = uint8(ave / training_set_size); 
    ave = double(ave);
%     ave = normalize(binarize(ave, 28, 28), 28, 28);
%     ave = binarize(ave, 28, 28);
%     count = sum(sum(ave));
%     for j=1:image_size*image_size
%         ave(j) = ave(j) / count;
%     end
    % Invert image
    
    % Draw image
%     figure
%     x = [1, 2];
%     y = [2, 1];
%     imagesc(x, y, test_set{1}); colormap(gray);