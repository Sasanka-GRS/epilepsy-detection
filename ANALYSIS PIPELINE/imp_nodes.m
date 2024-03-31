%%%%% Analyze network metrics for important nodes (visualization only) %%%%%

clc
clear
close all

%% Read adj

graphs = load("theta_A_W_uni10_100ms.mat").W;
N = size(graphs);
L = N(1);
N = N(3);

%% Calculate centralities

E = zeros(L,N);
C = zeros(L,N);

for i = 1:N
    A = graphs(:,:,i);

    %%%% Eigen centrality
    eigC = eigencentrality(A);

    %%% Closeness Centrality
    clC = closeness(A);

    E(:,i) = eigC;
    C(:,i) = clC;
end

%% Add Centralities

Centrality = abs(E + 2*C);

%% Pick top K

num = floor(L/10);
nodeIMP = zeros(L,N);

for i = 1:N
    sorted = sort(Centrality(:,i),'descend');
    thresh = sorted(num);
    nodeIMP(Centrality(:,i)>=thresh,i) = 1;
    nodeIMP(Centrality(:,i)<thresh,i) = 0;
end

%% Get subgraph

subgraphs = zeros(num,num,L);

for i = 1:N
    subgraphs(:,:,i) = graphs(nodeIMP(:,i)==1,nodeIMP(:,i)==1,i);
end

%% Calculate CC, MOD and EFF

CC = zeros(N,1);
MOD = zeros(N,1);
EFF = zeros(N,1);

for i = 1:N
    CC(i) = clust_coeff(subgraphs(:,:,i));
    modules = newman_eigenvector_method(subgraphs(:,:,i));
    MOD(i) = modularity_metric(modules,subgraphs(:,:,i));
end

dist = zeros(num,num,N);

for k=1:N
    for i=1:num
        dist(i,:,k) = simple_dijkstra(subgraphs(:,:,k),i);
    end
end

for k=1:N
    for i=1:num
        for j=i+1:num
            EFF(k) = EFF(k) + (1/dist(i,j,k));
        end
    end
    EFF(k) = EFF(k)/(0.5*num*(num+1));
end

%% Plot

figure()
subplot(3,1,1)
plot(CC)
hold on
xline(200, '--r', LineWidth=1.5)
xline(1100, '--r', LineWidth=1.5);
hold off
title('CC')

subplot(3,1,2)
plot(MOD)
hold on
xline(200, '--r', LineWidth=1.5)
xline(1100, '--r', LineWidth=1.5);
hold off
title('MOD')

subplot(3,1,3)
plot(EFF)
hold on
xline(200, '--r', LineWidth=1.5)
xline(1100, '--r', LineWidth=1.5);
hold off
title('EFF')

sgtitle('Network Metrics for Important Nodes')