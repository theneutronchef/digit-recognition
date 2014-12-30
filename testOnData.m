input = data_array;
K = set_size * 10;
y1 = sigmoid(w' * input + w0 * ones(1, K) );
z1 = sigmoid(v' * y1 + v0 * ones(1, K));

[a b] = max(z1);
[a1 b1] = size(b);
sizes = a1 * b1;
count = 0;
answer = [10*ones(1,set_size) 9*ones(1,set_size) 8*ones(1,set_size) 7*ones(1,set_size) 6*ones(1,set_size) 5*ones(1,set_size) 4*ones(1,set_size) 3*ones(1,set_size) 2*ones(1,set_size) ones(1,set_size) ];
for i=1:sizes 
   if b(i) == answer(i)
       count = count + 1;
   end
end

accuracy = count / sizes