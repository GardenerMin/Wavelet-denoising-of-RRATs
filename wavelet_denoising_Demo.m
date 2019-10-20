%%% Wavelet Denoising Demo for RRATs time series 
%%% Please selected proper Wavelet thresholding parameters in Lines 39,40
%%% Written by Min Jiang on Sep 3, 2014.

clear;clc
load('RR0074_0271.mat')   
sample_time=0.0001; %unit: s
candidate_period=1.231327724079268;   %unit: s

% Visulize original signal
figure,plot(time,intensity);
xlabel('Time (s)')
ylabel('Intensity') 
title('Original Signal.');
xlim([497 500])   % select the time window to show

% wavelet decomposition
[c,l]=wavedec(intensity,14,'db5');   
% reconstruct signal from specified level (without thresholding) 
amp_dc1=wrcoef('d',c,l,'db5',1);   
amp_dc2=wrcoef('d',c,l,'db5',2);
amp_dc3=wrcoef('d',c,l,'db5',3);
amp_dc4=wrcoef('d',c,l,'db5',4); 
amp_dc5=wrcoef('d',c,l,'db5',5);
amp_dc6=wrcoef('d',c,l,'db5',6);
amp_dc7=wrcoef('d',c,l,'db5',7);
amp_dc8=wrcoef('d',c,l,'db5',8);
amp_dc9=wrcoef('d',c,l,'db5',9);
amp_dc10=wrcoef('d',c,l,'db5',10);
amp_dc11=wrcoef('d',c,l,'db5',11);
amp_dc12=wrcoef('d',c,l,'db5',12);
amp_dc13=wrcoef('d',c,l,'db5',13);
amp_dc14=wrcoef('d',c,l,'db5',14);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wavelet thresholding parameters
N=[1,2,3,4,5,6,7,8,9,10,11,12,13,14];
T=[1000,1000,1000,1000,1000,1000,25,17,12,10,9,7,5,3];       
nc=wthcoef('t',c,l,N,T,'h');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Wavelet reconstruction
% Reconstruct singal from Level 1 to 14 with thresholding
xd=waverec(nc,l,'db5');
recon_dc1=wrcoef('d',nc,l,'db5',1);
recon_dc2=wrcoef('d',nc,l,'db5',2);
recon_dc3=wrcoef('d',nc,l,'db5',3);
recon_dc4=wrcoef('d',nc,l,'db5',4);
recon_dc5=wrcoef('d',nc,l,'db5',5);
recon_dc6=wrcoef('d',nc,l,'db5',6);
recon_dc7=wrcoef('d',nc,l,'db5',7);
recon_dc8=wrcoef('d',nc,l,'db5',8);
recon_dc9=wrcoef('d',nc,l,'db5',9);
recon_dc10=wrcoef('d',nc,l,'db5',10);
recon_dc11=wrcoef('d',nc,l,'db5',11);
recon_dc12=wrcoef('d',nc,l,'db5',12);
recon_dc13=wrcoef('d',nc,l,'db5',13);
recon_dc14=wrcoef('d',nc,l,'db5',14);

% Visulize original and denoised signal
figure,
subplot(2,1,1)
plot(time,intensity);
xlim([495.5 497.5]) ;
ylim([-50 50]) 
title('J1048-5838 original signal')
subplot(2,1,2)
plot(time,xd);
xlim([495.5 497.5]) ;
ylim([-50 50]) 
title('J1048-5838 wavelet denoised signal')

% Visulize original and denoised signal on the specified level 
figure,
subplot(2,1,1)
plot(time,amp_dc7);
xlim([495.5 497.5]) ;
ylim([-20 20])
subplot(2,1,2)
plot(time,recon_dc7);
xlim([495.5 497.5]) ;
ylim([-20 20])

% Visulize original signal on the specified level 
% (Fig. 4 in the Paper, if replace "amp" with "recon", it is shown as the Fig.5 in the Paper) 
figure,
subplot(5,3,1)
plot(time,intensity);
xlim([495.5 497.5]);ylim([-50 50]);xlabel('s');ylabel('Intensity') 
subplot(5,3,2)
figure,plot(time,amp_dc1);
xlim([495.5 497.5]);ylim([-50 50]);xlabel('s');ylabel('Intensity') 
subplot(5,3,3)
figure,plot(time,amp_dc2);
xlim([495.5 497.5]);ylim([-50 50]);xlabel('s');ylabel('Intensity'); 
subplot(5,3,4)
figure,plot(time,amp_dc3);
xlim([495.5 497.5]); ylim([-20 20]);xlabel('s');ylabel('Intensity');
subplot(5,3,5)
figure,plot(time,amp_dc4);
xlim([495.5 497.5]); ylim([-20 20]);xlabel('s');ylabel('Intensity') 
subplot(5,3,6)
figure,plot(time,amp_dc5); 
xlim([495.5 497.5]); ylim([-20 20]);xlabel('s');ylabel('Intensity') 
subplot(5,3,7)
figure,plot(time,amp_dc6);
xlim([495.5 497.5]); ylim([-20 20]); xlabel('s');ylabel('Intensity') 
subplot(5,3,8)
figure,plot(time,amp_dc7);
xlim([495.5 497.5]); ylim([-20 20]);xlabel('s');ylabel('Intensity') 
subplot(5,3,9)
figure,plot(time,amp_dc8);
xlim([495.5 497.5]);ylim([-20 20]);xlabel('s');ylabel('Intensity') 
subplot(5,3,10)
figure,plot(time,amp_dc9);
xlim([495.5 497.5]); ylim([-2 2]);xlabel('s');ylabel('Intensity') 
subplot(5,3,11)
figure,plot(time,amp_dc10); 
xlim([495.5 497.5]);ylim([-2 2]);xlabel('s');ylabel('Intensity'); 
subplot(5,3,12)
figure,plot(time,amp_dc11);
xlim([495.5 497.5]);ylim([-2 2]); xlabel('s');ylabel('Intensity') 
subplot(5,3,13)
figure,plot(time,amp_dc12);
xlim([495.5 497.5]); ylim([-1 1]);xlabel('s');ylabel('Intensity'); 
subplot(5,3,14)
figure,plot(time,amp_dc13);
xlim([495.5 497.5]); ylim([-1 1]);xlabel('s');ylabel('Intensity') 
subplot(5,3,15)
figure,plot(time,amp_dc14);
xlim([495.5 497.5]); ylim([-1 1]);xlabel('s');ylabel('Intensity') 

% Save the denoised data
inten=xd; 
save('RR0074_0271_fil.mat','time','inten');


