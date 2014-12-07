%Tavas, Romelio Jr. 2011-11218
%Gomez, Emilio Vicente 2009-22091

%HONOR CODE
%I do hereby affirm, on my honor as a student at the end of this exam, that
%I had no unlawful knowledge of the questions or answers prior to this 
%exercise and that I have neither given nor received assistance in answering 
%any of the questions during this exam.


function  Z = calcSTZCR(sig,window_len,window_overlap,window_type)


Ns = max(size(sig));

%construct window depending on window_type
if(strcmp(window_type,'Rectangular'))
    window = rectwin(window_len);
elseif (strcmp(window_type,'Hamming'))
    window = hamming(window_len);
end

% Framing and windowing of the signal 
sig_framed = buffer(sig, window_len, window_overlap, 'nodelay');
sig_windowed = diag(sparse(window)) * sig_framed;

disp(size(sig_windowed));

cols = size(sig_windowed,2);

padding = zeros(1,cols);

sig_windowed = vertcat(sig_windowed,padding);

Z = zeros(cols,1);

for i = 1:cols
  
    for j = 1:window_len
    
        x = abs(sig_windowed(j+1,i)-sig_windowed(j,i))/(2*window_len);
        
    end
        Z(i) = sum(x);
end

Z = normc(Z);

% 
% for n = 1+window_len:Ns; % calcola la Short-Time Average ZCR
%     Z_init(n,1) = sum(abs(sign(sig(n-window_len+1:n))- ...
%     sign(sig(n-window_len:n-1)))/2)/window_len;
% end;
% 
% 
% 
% Z = sum(Z);

end