function p = sigmoidinv(x)
% Inverse sigmoid function
p = 1./(1+exp(-x)) * (1 - 1./(1+exp(-x)));
end