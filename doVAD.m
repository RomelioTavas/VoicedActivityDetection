clc;clear all;

[sig,fs] = wavread('AudioFiles/BakitMatagalAngSundoKo');

frame_len = 320; %20ms

z = calcSTZCR(sig,frame_len,0,'Rectangular');


energy = calcSTE(sig,frame_len,0,'Hamming');



plot(z);
 
% %assume first 10 frames are noise
% z_10 = z(1:frame_len*10);
% energy_10 = energy(1:frame_len*10);
% 
% Sc = 1000;
% w = energy .* (1-z) * Sc; 
% w_10 = energy_10 .* (1-z_10) * Sc;
% 
% %define trigger
% t = mean(w_10) + (0.3*var(w_10)^-0.92) * var(w_10);
% 


