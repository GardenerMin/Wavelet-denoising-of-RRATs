function [candiate_toa]=TOAs_calculation(intensity, time, candidate_period, sample_time, SNR_threshold)
%%% This is the function which calculate candidate TOAs from the filtered
%%% RRAT time series
%%% Written by Min Jiang on Sep 5, 2014.

% number of samples in one period,calculated by:floor(candidate_period/sample_time)
interval_num=floor(candidate_period/sample_time);
m=length(intensity);
variance(1:m)=0;
Exd(1:m)=0;
var_num=floor(m/interval_num);
for j=1:var_num       
      mean=0;
      rms=0;
  for i=1:interval_num
     mean=mean+intensity((j-1)*interval_num+i);   
     rms=rms+intensity((j-1)*interval_num+i)*intensity((j-1)*interval_num+i);
 end
 smean=mean;
 mean=mean/interval_num;
 srms=rms;
 tet=rms-interval_num*(mean.^2);
 if tet<0
    circulate1=1;
 else
     rms=((rms-interval_num*(mean.^2))/(interval_num-1)).^0.5;
 end
 npulse=1;
 for i=1:interval_num
     x=(intensity(i)-mean)/rms;
     if x>SNR_threshold
         pulses_amp(npulse)=x;
        smean=smean-intensity(i);
         srms=srms-intensity(i)*intensity(i);
         npulse=npulse+1;
     end
 end 
 mean=smean/(interval_num-npulse);
 tet=srms-(interval_num-npulse)*(mean.^2);
 
 if tet<0
    circulate2=2;
    ES=0;
    for i=1:(npulse-1)
     E=(pulses_amp(i)-mean).^2;
     ES=ES+E;
    end
    snr1=ES/(rms.^2);
    
 else
     rms=((srms-(interval_num-npulse)*(mean.^2))/(interval_num-npulse-1)).^0.5;
 end
 npulse=1;
 for i=1:interval_num
     x=(intensity(i)-mean)/rms;
     if x>SNR_threshold
         num(npulse)=i;
         SNR(npulse)=x;
         SNR2(npulse)=((intensity(i)-mean).^2)/(rms.^2);
         pulses_amp(npulse)=intensity(i); 
         smean=smean-intensity(i);
         srms=srms-intensity(i)*intensity(i);
         npulse=npulse+1;
     end
 end
 mean=smean/(interval_num-npulse);
 rms=((srms-(interval_num-npulse)*(mean.^2))/(interval_num-npulse-1)).^0.5; 
  variance(((j-1)*interval_num+1):(j*interval_num))=rms;
  Exd(((j-1)*interval_num+1):(j*interval_num))=mean;
end

if (var_num*interval_num)<m
    variance((var_num*interval_num+1):m)=rms;
    Exd((var_num*interval_num+1):m)=mean;
end

% equal to "interval_num", calculated by ceil(candidate_period/sample_time); 
period = floor(candidate_period/sample_time);
turn=floor(m/period);  
for n=1:turn
     period_max(n)=intensity((n-1)*period+1);
     for compare=1:period
        if (intensity((n-1)*period+compare)>period_max(n)) 
            period_max(n)=intensity((n-1)*period+compare);
            pulse_record(n)=(n-1)*period+compare;
        end
     end
     if period_max(n) == intensity((n-1)*period+1)
        pulse_record(n)=(n-1)*period+1;
     end
 end
                    
pulse_num=0;
for n=1:turn
     if (((period_max(n)-Exd(pulse_record(n)))/variance(pulse_record(n)))>SNR_threshold)
         pulse_num=pulse_num+1;
         toa(pulse_num)=time(pulse_record(n)); 
         pulse_sigma(pulse_num)=(period_max(n)-Exd(pulse_record(n)))/variance(pulse_record(n));     
         pulse_periods_num(pulse_num)=ceil(toa(pulse_num)/candidate_period);
     end
 end
 
n=length(toa);
candiate_toa = [];
for i=1:(n-1)
    difference=(toa(i+1)-toa(i))/candidate_period;   %test if TOAs is a good candidate
    if mod(difference,1) > 0.99 || mod(difference,1) < 0.01
        candiate_toa = [candiate_toa; toa(i); toa(i+1)]; 
    end
end
candiate_toa = unique(candiate_toa);