%Tavas, Romelio Jr. 2011-11218
%Gomez, Emilio Vicente 2009-22091

%HONOR CODE
%I do hereby affirm, on my honor as a student at the end of this exam, that
%I had no unlawful knowledge of the questions or answers prior to this 
%exercise and that I have neither given nor received assistance in answering 
%any of the questions during this exam.


function  Z = calcSTZCR(sig,l,ovrlp,window_type)
%calcSTZCR
% Computes the short time zero crossing rate
%
% USAGE:	Z = calcSTZCR(sig,l,ovrlp,window_type)
% INPUT:	sig = input signal vector
%           l = length of window
%           ovrlp = window overlap
%           window_type = 'rectwin' or 'hamming'           
% OUTPUT:	Z = zero crossing rate 


Ns = max(size(sig));

%construct window depending on window_type
% if(strcmp(window_type,'Rectangular'))
%     window = rectwin(window_len);
% elseif (strcmp(window_type,'Hamming'))
%     window = hamming(window_len);
% end
wndw = window(window_type,l);

% Framing and windowing of the signal 
sig_framed = buffer(sig, l, ovrlp, 'nodelay');
sig_windowed = diag(sparse(wndw)) * sig_framed;

disp(size(sig_windowed));

cols = size(sig_windowed,2);

padding = zeros(1,cols);

sig_windowed = vertcat(sig_windowed,padding);

Z = zeros(cols,1);

for i = 1:cols
  
    for j = 1:l
    
        x = abs(sig_windowed(j+1,i)-sig_windowed(j,i))/(2*l);
        
    end
        Z(i) = sum(x);
end
    Z = Z./max(Z);
end