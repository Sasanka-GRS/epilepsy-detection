%%%%% Single Frequency Filtering (TFA) %%%%%

function [S, f, t] = sff(x, minfreq, maxfreq, freqStep, Fs)

%% Initialize parameters
a = 0.995;

%% Time
N = length(x); % Number of time instants
t = 0:1/Fs:(N-1)/Fs;

%% Freq
f = minfreq:freqStep:maxfreq; 
K = length(f); % Number of distinct instants

%% Joint transform
S = zeros(K,N);

%% Filterbanks

F.b = ones(1,K);
aTemp = zeros(2,K);

for i=1:K
    wTildak = f(i);
    wk = 2*pi*wTildak/Fs;
    ak = a*exp(-1j*wk);
    aTemp(:,i) = [1,-ak];
end

F.a = aTemp;

%% Filtering

for i=1:K
    ha = F.a(:,i);
    hb = F.b(i);
    STemp = filter(hb,ha,x);
    S(i,:) = fft(STemp)/norm(STemp,2);
end

%% PSD
%{
for i=1:K
    [auto,~] = 

end
%}