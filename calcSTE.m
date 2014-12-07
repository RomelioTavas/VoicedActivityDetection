%Tavas, 2011-11218
%Palafox, 2009-53518

%HONOR CODE
% I do hereby affirm, on my honor as a student at the end of this exercise, 
% that I had no unlawful knowledge of the questions or answers prior to this exercise 
% and that I have neither given nor received assistance in answering any of the questions during this exercise.


function energyST = calcSTE(sig,window_len,frame_overlap, window_type)
%CALCSTE Summary of this function goes here
%   Input Arguments
%   filename - filename of the speech file to process
%   frame_len - window length
%   frame_overlap - window overlap 
%   window_type - type of window to use


%construct window depending on window_type
% if(strcmp(window_type,'Rectangular'))
%     window = rectwin(window_len);
% elseif (strcmp(window_type,'Hamming'))
%     window = hamming(window_len);
% end
wndw = window(window_type,window_len);

% Framing and windowing of the signal 
sig_framed = buffer(sig, window_len, frame_overlap, 'nodelay');
sig_windowed = diag(sparse(wndw)) * sig_framed;



% compute the short time energy of the signal
energyST = sum(sig_windowed.^2)/window_len;
energyST = energyST'; %column vector


end

