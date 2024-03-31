%%%%% Save graphs learnt using similarity based graph learning method %%%%%

clc
clear

%% Extract Data

r1 = load("SeizurePartitioning.mat").r1;
r2 = load("SeizurePartitioning.mat").r2;
r3 = load("SeizurePartitioning.mat").r3;
r4 = load("SeizurePartitioning.mat").r4;
r5 = load("SeizurePartitioning.mat").r5;
total = load("SeizurePartitioning.mat").C;

%% Declare Variables

win = 10; % Time window length
sigma = 1; % Parameter determining connections (variance of gaussian distance)

%% Region 1

G1 = simWindowLearn(r1,win,sigma);

%% Region 2

G2 = simWindowLearn(r2,win,sigma);

%% Region 3

G3 = simWindowLearn(r3,win,sigma);

%% Region 4

G4 = simWindowLearn(r4,win,sigma);

%% Region 5

G5 = simWindowLearn(r5,win,sigma);

%% Save

save('10SimWindow_01.mat','G1','G2','G3','G4','G5');