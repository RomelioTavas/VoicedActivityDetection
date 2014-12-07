%Tavas, Romelio Jr. 2011-11218
%Gomez, Emilio Vicente 2009-22091


%This is a THD04 code with some modifications
%Tavas, 2011-11218
%Palafox, 2009-53518

%HONOR CODE
% I do hereby affirm, on my honor as a student at the end of this exercise, 
% that I had no unlawful knowledge of the questions or answers prior to this exercise 
% and that I have neither given nor received assistance in answering any of the questions during this exercise.
%
%CALCSTE Summary of this function goes here
%   Input Arguments
%   filename - filename of the speech file to process
%   frame_len - window length
%   frame_overlap - window overlap 
%   window_type - type of window to use


function energyST = calcSTE(sig,window_len,frame_overlap, window_type)


wndw = window(window_type,window_len);

% Framing and windowing of the signal 
sig_framed = buffer(sig, window_len, frame_overlap, 'nodelay');
sig_windowed = diag(sparse(wndw)) * sig_framed;


% compute the short time energy of the signal
energyST = sum(sig_windowed.^2)/window_len;
energyST = energyST'; %column vector


end

