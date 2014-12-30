count = 0;
for i=1:8
    y_layer1 = w' * data(1:N, i:i) + w0 * ones(1,1);
    z_layer1 = sigmoid(y_layer1)' * v + v0';
    [val1, output1] = max(sigmoid(z_layer1))
    if output1 == teacher(i) + 1
        count = count + 1;
    end
end
show = count