%%%% This code is to save the network properties - clustering coefficient, modularity and efficiency %%%%%

clc
clear

%% Load data

num = "uni88"; % Subject name
mat_name = "theta_A_W_" + num + "_50ms.mat"; % Rename this with the name file you want to load/read
load(mat_name);

sz = size(A);
T = sz(3); % Number of time-stamps
N = sz(1); % Number of nodes

%% Find coefficients

% Initialize
CC = zeros(T,1);
EFF = zeros(T,1);
MOD = zeros(T,1);

% Calculate
for k=1:T
    CC(k) = clust_coeff(A(:,:,k));
    modules = newman_eigenvector_method(A(:,:,k));
    MOD(k) = modularity_metric(modules,A(:,:,k));
end

dist = zeros(N,N,T);

for k=1:T
    for i=1:N
        dist(i,:,k) = simple_dijkstra(A(:,:,k),i);
    end
end

for k=1:T
    for i=1:N
        for j=i+1:N
            EFF(k) = EFF(k) + (1/dist(i,j,k));
        end
    end
    EFF(k) = EFF(k)/(0.5*N*(N+1));
end

%% Save them into MATLAB Data files

save("network_properties_"+ num+"_50ms.mat","CC","EFF","MOD");