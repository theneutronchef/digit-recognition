% Multilayer neural network (with 2 hidden layers)

sigmoid = @(x) 1 ./ (1 + exp(-x));

% initialize data array
data=data_array;
[N K]=size(data);
num_digits = 10;
num_hidden1 = 200;
num_hidden2 = 30;

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
v=randn(num_hidden2,num_digits);
v0=randn(num_digits, 1);
w=randn(N,num_hidden1);
w0=randn(num_hidden1,1);

ww=randn(num_hidden1, num_hidden2);
ww0=randn(num_hidden2,1);
dw = zeros(N, num_hidden1);
dv = zeros(num_hidden2, num_digits);
dw0 = zeros(num_hidden1, 1);
dv0 = zeros(num_digits, 1);

dww = zeros(num_hidden1, num_hidden2);
dww0 = zeros(num_hidden2, 1);

   
% loop over trials
for t=1:num_trials
   fprintf(strcat('trial', int2str(t)));
    % compute y layer
    y = sigmoid(w' * data + w0 * ones(1, K));
    
    % compute hidden layer
    yz = sigmoid(ww' * y + ww0 * ones(1, K));

    % compute z layer
    z = sigmoid(v' * yz + v0 * ones(1, K));
    
    % compute error
    delta =  teacher - z;
    d_min = sum(delta);
    E(t)  = d_min * d_min';
    
    % compute delta_z
    dsig    = z .* (1 - z);
    delta_z = delta .* dsig;
    
    % compute delta_yz
    dsig    = yz .* (1 - yz);
    delta_yz = dsig .* (v * delta_z);
    
    % compute delta_y
    dsig    = y .* (1 - y);
    delta_y = dsig .* (ww * delta_yz);
    
    % accumulate dw
    dw  = eta * data * delta_y' + alpha * dw;
    dw0 = eta * sum(delta_y, 2) + alpha * dw0;
    
    % accumulate dww
    dww  = eta * y * delta_yz' + alpha * dww ;
    dww0 = eta * sum(delta_yz, 2) + alpha * dww0;
    
    % accumulate dv
    dv  = eta * yz * delta_z' + alpha * dv ;
    dv0 = eta * sum(delta_z, 2) + alpha * dv0;
    
    % update weights
    w  = w  + dw;
    w0 = w0 + dw0;
    v = v + dv;
    v0 = v0 + dv0;
    ww = ww + dww;
    ww0 = ww0 + dww0;

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
