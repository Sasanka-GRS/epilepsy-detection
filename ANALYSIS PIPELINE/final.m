%%%%% Perform STFT and TFA on the data (Only for visualization) %%%%%

%% Define parameters

Fs = 200;
minfreq = 4;
maxfreq = 8;
freqStep = 0.1;

%% Load Data

data = load('SeizurePartitioning.mat');

r1 = data.r1;
r2 = data.r2;
r3 = data.r3;
r4 = data.r4;
r5 = data.r5;

n = 1; % Choose one electrode just for plotting purposes
X = [r1(:, n); r2(:, n); r3(:,n); r4(:, n); r5(:, n)];

%% BPF

figure()
subplot(6,1,1)
plot(X);
hold on
xline(5000, '--r', LineWidth=1.5)
xline(length(X)-5000, '--r', LineWidth=1.5);
hold off
xlabel('t')
title('Original Signal')
y_delta = BPF_delta(X);
subplot(6,1,2)
plot(y_delta);
hold on
xline(5000, '--r', LineWidth=1.5)
xline(length(X)-5000, '--r', LineWidth=1.5);
hold off
xlabel('t')
title('\delta band')
y_theta = BPF_theta(X);
subplot(6,1,3)
plot(y_theta);
hold on
xline(5000, '--r', LineWidth=1.5)
xline(length(X)-5000, '--r', LineWidth=1.5);
hold off
xlabel('t')
title('\theta band')
y_alpha = BPF_alpha(X);
subplot(6,1,4)
plot(y_alpha);
hold on
xline(5000, '--r', LineWidth=1.5)
xline(length(X)-5000, '--r', LineWidth=1.5);
hold off
xlabel('t')
title('\alpha band')
y_beta = BPF_beta(X);
subplot(6,1,5)
plot(y_beta);
hold on
xline(5000, '--r', LineWidth=1.5)
xline(length(X)-5000, '--r', LineWidth=1.5);
hold off
xlabel('t')
title('\beta band')
y_gamma = BPF_gamma(X);
subplot(6,1,6)
plot(y_gamma);
hold on
xline(5000, '--r', LineWidth=1.5)
xline(length(X)-5000, '--r', LineWidth=1.5);
hold off
xlabel('t')
title('\gamma band')

%% Perform TFA

% STFT

figure()
win = hamming(100,"periodic");
d = seconds(1e-3);
stft(y_theta,d,Window=win,OverlapLength=98,FFTLength=128);
hold on
xline(5, '--r', LineWidth=1.5)
xline(24, '--r', LineWidth=1.5);
hold off
%spectrogram(y_gamma);
title('STFT');

% SFF

figure()
[S,f,t] = sff(y_theta, minfreq, maxfreq, freqStep, Fs);
imagesc(t,f,abs(S).^2);
colorbar
hold on
xline(5000/200, '--r', LineWidth=1.5)
xline((length(X)-5000)/200, '--r', LineWidth=1.5);
hold off
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('SFF');

% S-Transform

figure()
[S,f,t] = sTransform(y_theta, minfreq, maxfreq, freqStep, Fs);
imagesc(t,flip(f),abs(S').^2);
colorbar
hold on
xline(30, '--r', LineWidth=1.5)
xline(120, '--r', LineWidth=1.5);
hold off
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('S-Transform');