%%%%% Generate random graphs given the number of nodes %%%%%

function [adj_ring, adj_rand, adj_sw, adj_sf] = generateGraphs(N)

%% Ring graph

adj_ring = zeros(N, N);
for i = 1:(N-1)
    adj_ring(i, i+1) = 1;
    adj_ring(i+1, i) = 1;
end
adj_ring(1,N) = 1;
adj_ring(N,1) = 1;

%% Random graph

adj_rand = adjProb(N,0.5);

%% Small-world network
adj_sw = adj_ring;
num_edges = ones(N)*2;

for i = 1:N
    idx = randi([1, num_edges(i)]);
    adj_sw(i, idx) = 0;
    adj_sw(idx, i) = 0;
    num_edges(i)=num_edges(i)-1;
    num_edges(idx)=num_edges(idx)-1;

    prob = num_edges/N;
    prob(i) = 0;
    lottery = zeros(N-1, 2);
    prev = 0;
    for j = 1:N
        lottery(j,1) = prev;
        lottery(j,2) = prev + prob(j);
        prev = prev + prob(j);
    end
    rand_num = rand(1);
    for j = 1:N
        if(rand_num < lottery(j, 2) && rand_num >= lottery(j, 1))
            adj_sw(i,j) = 1;
            adj_sw(j,i) = 1;
            num_edges(i) = num_edges(i) + 1;
            num_edges(j) = num_edges(j) + 1;
            break
        end
    end
end

%% Scale-free

adj_sf = zeros(N,N);
num_edges = zeros(N);

n1 = 0;
n2 = 0;
while n1==n2
    n1 = randi([1,N]);
    n2 = randi([1,N]);
end

vis = zeros(N);
vis(n1) = 1;
vis(n2) = 1;
num_edges(n1) = 1;
num_edges(n2) = 1;

adj_sf(n1,n2)=1;
adj_sf(n2,n1)=1;

for i = 1:N
    if(vis(i) == 1)
        continue
    end
    vis(i) = 1;
    prob = num_edges/sum(num_edges);
    lottery = zeros(N-1, 2);
    prev = 0;
    for j = 1:N
        lottery(j,1) = prev;
        lottery(j,2) = prev + prob(j);
        prev = prev + prob(j);
    end
    rand_num = rand(1);
    for j = 1:N
        if(rand_num < lottery(j, 2) && rand_num >= lottery(j, 1))
            adj_sf(i,j) = 1;
            adj_sf(j,i) = 1;
            num_edges(i) = num_edges(i) + 1;
            num_edges(j) = num_edges(j) + 1;
            break
        end
    end
end
end