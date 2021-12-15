clc;
clear all;
d=xlsread("E:\Work\AR_project_new\pam_brow\p1_c0.5\Data_24_11_2020_3.xlsx");
data=d(:,2);
data=(data-mean(data))/std(data);

dt=d(2,1)-d(1,1);
Fs=1/dt;
max_order=50;
ar_coeff=arcov(data,max_order);

figure(1)
plot((1:10),(-ar_coeff(2:11)),'r');hold on;
%set(gca, 'YScale', 'log');hold on;
store=ar_coeff(2:11)';

%% generation of noise
% plot(store,'r');hold on;
% noise=zeros(1,length(data));
% 
% s=0.1; %%stepsize
% for k=1:20   
% for i=length(store)+1:length(data)
% count=0;
% for j=1:length(store)
% count=count-data(i-j)*(store(j));
% end
% noise(i)=data(i)-count;
% end
% correlation=xcorr(noise,noise)./max(xcorr(noise,noise));
% value=correlation(length(noise)+2)
% store=store+s*value; 
% end
% 
% plot(store,'b')