%%%%% Normalize the data to have mean 0 and variance 1 %%%%%

function y = dataNorm(x)
l = size(x);
y = x;
for k = 1:l(2)
    x1 = x(:,k);
    mean = sum(x1)/l(1);
    v = var(x1); % Use inbuilt
    Y = (x1-mean)/sqrt(v);
    y(:,k) = Y;
end
end