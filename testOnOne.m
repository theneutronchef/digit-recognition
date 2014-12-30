input = data_array;
K = set_size * 10;
y1 = sigmoid(w' * input + w0 * ones(1, K) );
z1 = sigmoid(v' * y1 + v0 * ones(1, K));
imagesc(reshape(input(1:784,1), 28, 28));axis xy;
[a b] = max(z1);
answer = mod((11 - b(1)), 10)

imagesc(reshape(input(1:784,201), 28, 28));axis xy;
[a b] = max(z1);
answer = mod((11 - b(201)), 10)