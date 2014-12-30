% Multilayer neural network (with 1 hidden layer)

sigmoid = @(x) 1 ./ (1 + exp(-x));

% initialize data array
data=data_array;
[N K]=size(data);
num_digits = 10;
num_hidden = 75;

% initialize teacher
one =   [0;0;0;0;0;0;0;0;0;1];
two =   [0;0;0;0;0;0;0;0;1;0];
three = [0;0;0;0;0;0;0;1;0;0];
four =  [0;0;0;0;0;0;1;0;0;0];
five =  [0;0;0;0;0;1;0;0;0;0];
six =   [0;0;0;0;1;0;0;0;0;0];
seven = [0;0;0;1;0;0;0;0;0;0];
eight = [0;0;1;0;0;0;0;0;0;0];
nine =  [0;1;0;0;0;0;0;0;0;0];
zero =  [1;0;0;0;0;0;0;0;0;0];
teacher = [one*ones(1,K/num_digits) two*ones(1,K/num_digits) three*ones(1,K/num_digits) four*ones(1,K/num_digits) five*ones(1,K/num_digits) six*ones(1,K/num_digits) seven*ones(1,K/num_digits) eight*ones(1,K/num_digits) nine*ones(1,K/num_digits) zero*ones(1,K/num_digits)];

% learning rate
eta=.005;

% number of trials - you may want to make this longer
num_trials=1000;

% initialize weights
v=randn(num_hidden,num_digits);
v0=randn(num_digits, 1);
w=randn(N,num_hidden);
w0=randn(num_hidden,1);

% dw = 0; dw0 = 0; dv = 0; dv0 = 0;
dw = zeros(N, num_hidden);
dv = zeros(num_hidden, num_digits);
dw0 = zeros(num_hidden, 1);
dv0 = zeros(num_digits, 1);

% loop over trials
for t=1:num_trials
   fprintf(strcat('trial', int2str(t)));

    % compute y layer
    y = sigmoid(w' * data + w0 * ones(1, K));
    
    % compute z layer
    z = sigmoid(v' * y + v0 * ones(1, K));
    
    % compute error
    delta =  teacher - z;
    d_min = sum(delta);
    E(t)  = d_min * d_min';
    
    % compute delta_z
    dsig    = z .* (1 - z);
    delta_z = delta .* dsig;
    
    % compute delta_y
    dsig    = y .* (1 - y);
    delta_y = dsig .* (v * delta_z);
    
    % accumulate dw
    dw  = eta * data * delta_y' + alpha * dw;
    dw0 = eta * sum(delta_y, 2) + alpha * dw0;
    
    % accumulate dv
    dv  = eta * y * delta_z';
    dv0 = eta * sum(delta_z, 2);
    
    % update weights
    w  = w  + dw;
    w0 = w0 + dw0;
    v = v + dv;
    v0 = v0 + dv0;
   
    % update E plot
    if t>1
      set(hE,'XData',[t-1 t],'YData',E(t-1:t))
    else
      figure(2)
      hE=plot(t,E(t),'EraseMode','none');
      axis([1 num_trials 0 E(1)])
    end
   
    drawnow
   
end
