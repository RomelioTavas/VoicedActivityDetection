
[sig,fs] = wavread('AudioFiles/vowel_a');


% Noise reduction code
% n = 7;
% beginFreq = 2100 / (fs/2);
% endFreq = 12000 / (fs/2);
% [b,a] = butter(n, [beginFreq, endFreq], 'bandpass');

% sig = filter(b,a,sig);

frame_len = 320; %20ms

z = calcSTZCR(sig,frame_len,frame_len/4,'Rectangular');
energy = calcSTE(sig,frame_len,frame_len/4,'Hamming');


% %assume first 50 frames are noise

Sc = 1000;
w = (energy .* (1-z)) * Sc; 
w_10 = w(1:10);
%define trigger
t = mean(w_10) + (0.3*var(w_10)^-0.92) * var(w_10);

vad = zeros(length(z),1);



for i = 1:length(z)
    if w(i)>t
        vad(i) = 1;
    else
        vad(i) = 0;
    end
end


startpt = find(vad,1,'first') * frame_len;
endpt = find(vad,1,'last') * frame_len;
% y = sig(startpt:endpt);
hold on;
plot(z);
plot(vad,'r');
hold off;

