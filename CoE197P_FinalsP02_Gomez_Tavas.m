%Tavas, Romelio Jr. 2011-11218
%Gomez, Emilio Vicente 2009-22091

%HONOR CODE
%I do hereby affirm, on my honor as a student at the end of this exam, that
%I had no unlawful knowledge of the questions or answers prior to this 
%exercise and that I have neither given nor received assistance in answering 
%any of the questions during this exam.

clear all;
clc;

% One Acoustic Unit
[sig1,fs1,regions1] = doVAD('AudioFiles/vowel_e.wav'); 
[sig2,fs2,regions2] = doVAD('AudioFiles/vowel_a.wav'); 
[sig3,fs3,regions3] = doVAD('AudioFiles/vowel_o.wav'); 

% One Word
[sig4,fs4,regions4] = doVAD('AudioFiles/Cherry.wav'); 
[sig5,fs5,regions5] = doVAD('AudioFiles/Orange.wav'); 
[sig6,fs6,regions6] = doVAD('AudioFiles/Banana.wav'); 

% One Short Sentence
[sig7,fs7,regions7] = doVAD('AudioFiles/YouAreAwesome.wav');
[sig8,fs8,regions8] = doVAD('AudioFiles/WeAreYoung.wav'); 
[sig9,fs9,regions9] = doVAD('AudioFiles/ShakeItOff.wav'); 
 

