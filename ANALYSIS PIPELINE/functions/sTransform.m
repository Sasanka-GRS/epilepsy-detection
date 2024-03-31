%%%%% S-transform (TFA) %%%%%

function [s, f, t] = sTransform(x, minfreq, maxfreq, freqStep, Fs)

%% Calculating Parameters
N = length(x);
t = 0:1/Fs:(N-1)/Fs;
f = minfreq:freqStep:maxfreq; 
K = length(f); % Number of distinct instants

%% FFT of signal
X1 = fft(x);
X = zeros(N,K);

for i=1:K
    X(:,i) = X1;
end

%% Gaussian function
h = zeros(N,K);

for i=1:N
    h(i,:) = (abs(f).*exp(-((i^2)*(f.^2)/2))/(sqrt(2*pi)))';
end

%% FFT of Gaussian function
H = zeros(N,K);

for i=1:K
    H(:,i) = fft(h(:,i));
end

%% Shifting FFT of signal
fShift = floor(f*N/Fs);

for i=1:K
    X(:,i) = circshift(X(:,i),fShift(i));
end

%% Multiplication
S = zeros(N,K);

for i=1:K
    S(:,i) = X(:,i).*H(:,i);
end

%% Inverse FFT
s = zeros(N,K);

for i=1:K
    s(:,i) = real(ifft(S(:,i)));
end

end