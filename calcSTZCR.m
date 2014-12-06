%Tavas, Romelio Jr. 2011-11218
%Gomez, Emilio Vicente 2009-22091

%HONOR CODE
%I do hereby affirm, on my honor as a student at the end of this exam, that
%I had no unlawful knowledge of the questions or answers prior to this 
%exercise and that I have neither given nor received assistance in answering 
%any of the questions during this exam.

[s,fS] = wavread('BakitMatagalAngSundoKo');

Nframe = 100; % number of frames
Ns = max(size(s));


for n = 1+Nframe:Ns; %Calculate Short Time ZCR
    Z(n,1) = sum(abs(sign(s(n-Nframe+1:n))- ...
    sign(s(n-Nframe:n-1)))/2)/Nframe;
end;
Z=Z*fS/1000; % Zero-Crossing per ms
% plot Z(t):
t = (1/fS)*[1:max(size(Z))];
plot(t,Z); xlabel('time (s)'); ylabel('ZCR/ms(t)');