%%%%% Main code - perform BPF, TFA and Graph learning %%%%%

clc
clear
close all

%% Load Data
data = load('Seizure_Timesig_Sub_uni11.mat');

data = data.C;
num = size(data);
N = num(1);

num = num(2);

%% Define parameters
L = 20;
sigma = 1;
bandChoice = 2; % 1 for delta, 2 for theta, 3 for alpha, 4 for beta, 5 for gamma
tfaChoice = 'ST'; % Or 'SFF', 'STFT'
Fs = 200;
freqStep = 0.1;

%% Windowing

start = 1;
last = L;

A = zeros(num,num,floor(N/L));
W = zeros(num,num,floor(N/L));
Top = zeros(num,num,floor(N/L));
Y = zeros(N,num,5);

%% BPF
for i=1:num
    y_delta = BPF_delta(data(:,i));
    y_theta = BPF_theta(data(:,i));
    y_alpha = BPF_alpha(data(:,i));
    y_beta = BPF_beta(data(:,i));
    y_gamma = BPF_gamma(data(:,i));
    Y(:,i,:) = [y_delta,y_theta,y_alpha,y_beta,y_gamma];
end

%% Choose freq band
tfaIn = Y(:,:,bandChoice);

%% TFA
tfaOut = tfa(tfaIn,tfaChoice,Fs,freqStep,bandChoice,num,N);

%% Run loop

for count = 1:floor(N/L)
    
    %% Extract window
    X = squeeze(tfaOut(:,start:last,:));

    %% Normalize data
    for i = 1:num
        m = max(max(X(:,:,i)));
        X(:,:,i) = X(:,:,i)/m;
    end

    %% Learn Graph
    [a,w,top] = learnGraph(X,sigma,num);

    %% Save
    A(:,:,count) = a;
    W(:,:,count) = w;
    Top(:,:,count) = top;
    
    %% Update
    start = start + L;
    last = last + L;

end

%% Save
save('theta_A_W_uni11_100ms.mat',"A","W","Top");