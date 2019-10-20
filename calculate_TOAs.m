%%% Calculate the TOAs in the wavelet filtered time series  
%%% Please set correct parameters of the signal/observation in Lines 8, 9
%%% And set the 'thresholding SNR' for TOAs calculation
%%% Written by Min Jiang on Sep 5, 2014.
clear;clc

load('RR0074_0271_fil.mat'); 
% parameters about the signal itself
sample_time=0.0001; %unit: s
candidate_period=1.231327724079268;
SNR_threshold=5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call TOAs_calculation function
[candiate_toa]=TOAs_calculation(intensity, time, candidate_period, sample_time, SNR_threshold);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% save TOAs
fid=fopen('candiate_toa.txt','wt');          
fprintf(fid,'%f\n',toa);
fclose(fid);




 

