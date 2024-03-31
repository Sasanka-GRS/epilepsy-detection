%%%%% Calculate TFA based on bandchoice and tfa choice %%%%%

function [S] = tfa(X,tfaChoice,Fs,freqStep,bandChoice,num,N)

minFreq = 0.5;
maxFreq = 4;

if(bandChoice==2)
    minFreq = 4;
    maxFreq = 8;
elseif(bandChoice==3)
    minFreq = 8;
    maxFreq = 13;
elseif(bandChoice==4)
    minFreq = 13;
    maxFreq = 30;
else
    minFreq = 30;
    maxFreq = 100;
end

f = minFreq:freqStep:maxFreq;

S = zeros(length(f),N,num);

if(strcmp(tfaChoice,'STFT'))
    for i=1:num
        win = hamming(100,"periodic");
        d = seconds(1e-3);
        STemp = stft(X(:,i),d,Window=win,OverlapLength=98,FFTLength=128);
        S(:,:,i) = abs(STemp).^2;
    end
elseif(strcmp(tfaChoice,'SFF'))
    for i=1:num
        [STemp,~,~] = sff(X(:,i), minFreq, maxFreq, freqStep, Fs);
        S(:,:,i) = abs(STemp).^2;
    end
else
    for i=1:num
        [STemp,~,~] = sTransform(X(:,i), minFreq, maxFreq, freqStep, Fs);
        S(:,:,i) = abs(STemp').^2;
    end
end

end
