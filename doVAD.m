%Tavas, Romelio Jr. 2011-11218
%Gomez, Emilio Vicente 2009-22091

%HONOR CODE
%I do hereby affirm, on my honor as a student at the end of this exam, that
%I had no unlawful knowledge of the questions or answers prior to this 
%exercise and that I have neither given nor received assistance in answering 
%any of the questions during this exam.
%
%calcSTZCR
% Computes the short time zero crossing rate
%
% USAGE:	[sig,fs,vad] = doVAD(wave); 
% INPUT:	
%           wave = file name ('AudioFiles/vowel_i.wav')       
% OUTPUT:	sig = signal vector of wav file
%           fs = sampling frequency of wav file
%           regions = transition regions 

function [sig,fs,regions] = doVAD(wave)


[sig,fs] = wavread(wave);

frame_len = 320; %20ms
%calculate the STZCR and STE 
z = calcSTZCR(sig,frame_len,frame_len/4,'rectwin');
energy = calcSTE(sig,frame_len,frame_len/4,'hamming');

Sc = 1000; %Scale factor
%define w as a function that uses STE and STZCR to compute for VAD
w = (energy .* (1-z)) * Sc; 

%Assume first 10 frames are noise
w_10 = w(1:10);

%The trigger level for the VAD was selected
%http://research.ijcaonline.org/iccia/number6/iccia1046.pdf
alpha = 0.3*var(w_10)^-0.92;
t = mean(w_10) + alpha * var(w_10);

%Initialize vad variable
vad = zeros(length(z),1);

%Voice Activity is detected if the w(i) is greater than the trigger.
for i = 1:length(z)
    if w(i)>t
        vad(i) = 1;
    else
        vad(i) = 0;
    end
end
%Smoothing was done twice to remove the narrow transisitions. 
%Spans and threshold levels were selected empirically.  
vad2 = smooth(vad,3);   %moving average over 3 samples. 
vad3 = vad2;
for i = 1:length(vad3)
    if vad3(i)>= 0.5 	%then quantizing back to 1 or 0 
        vad3(i) = 1;
    else 
        vad3(i) = 0;
    end
end
vad4 = smooth(vad3,11); %moving average over 11 samples
vad5 = vad4;
for i = 1:length(vad)
    if vad5(i)>= 0.2    %because of the larger span the threshold was lower
        vad5(i) = 1;
    else 
        vad5(i) = 0;
    end
end



%collect all speech segment regions

%conversion factor of frame number to sample number
frame_equiv = frame_len - (frame_len/4);

%collect all the indexes of  the rising and falling edge of the VAD signal
ind = vad5>0;
edge_indices= find([0;abs(diff(ind))>0]);

%divide into 2 x N matrix, where N is the number of speech segments
% to correspond for start and end point of the signal
regions = buffer(edge_indices,2,0,'nodelay');

%convert regions to sample number
regions = regions.*frame_equiv;
regions_plot = edge_indices.*frame_equiv; %this is just for plootting


%Plot the speech signal with each speech segment marked
figure('name',wave);

x = 1:length(sig);
ymarker = sig(regions_plot);
hold on;
plot(x,abs(sig),'b',regions_plot,ymarker,'r*','MarkerSize',20);
legend('Speech Signal','Start and End Points');
xlabel('n sample'); ylabel('x[n]');
title('Speech Signal');
hold off;

end
