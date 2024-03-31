%%%%% Graph learning from data (Similarity methdod) %%%%%

function out = simWindowLearn(data,win,sigma)

L = size(data);
T = L(1);
N = L(2);

data = dataNorm(data);
Graphs_W = zeros(N,N,T-win+1);

start = 1;
last = win;

while (last <= T)

    x = data(start:last,:);

    W = zeros(N,N);

    for i = 1:N
        for j = 1:N
            if(i~=j)
                W(i,j) = exp((norm(x(:,i)-x(:,j),2))/(2*(sigma^2))); % Vector distances
            end
        end
    end

    A = W;
    [W,~] = thres1(A,N,3);
    W = normAdj(W);

    Graphs_W(:,:,start) = W;

    start = start + 1;
    last = last  + 1;

end

out = sum(Graphs_W,3)/(T-win+1);

end