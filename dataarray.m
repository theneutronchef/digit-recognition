

set_size = 200;

data_array = zeros(784, 10*set_size);
image_size = 28;


for i=1:10
    filename = strcat('data', int2str(mod(i,10)));
    fid=fopen(filename,'r');
    for j=1:set_size 
        m = fread(fid,[image_size image_size],'uint8');
        pos = (i-1) * set_size + j;
        data_array(1:image_size*image_size, pos:pos) = reshape(binarize2(rot90(m), 28, 28), 784, 1);
    end

end 
