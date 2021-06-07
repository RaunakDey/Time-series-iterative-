clc;
clear all;

%% simulating the motion of trapped bead
%%%%% parameter defined %%%%%
n=100e4; %number of data points
r2=randn(1,n);

%%% parameters %%%
eta=89e-5;
a=1.5e-6;
gamma=6*pi*eta*a;
fc=150;
td=1/(2*pi*fc);
kb=1.38e-23;
T=300;
D=kb*T/gamma;
k=2*pi*fc*gamma;
dt=0.0001;


%position simulated
x_pos=zeros(1,n);
time=zeros(1,n);
x_pos(1)=0;
for i=2:n
   x_pos(i)=x_pos(i-1)+dt*(-(x_pos(i-1))/td)+sqrt(2*D*dt)*r2(i-1); 
   time(i)=time(i-1)+dt;
end

%% using our technique -- read the paper for details

data=x_pos-mean(x_pos);
Fs = 1/dt;

%initialise a corner freq guess value, say 500
l=500; 
k=12*pi^2*eta*1.5e-6*l;
for i=1:n-1
noise(i)=-6*pi*eta*1.5e-6*(data(i+1)-data(i))*Fs-k*data(i);
end
noise(n)=0;
noise=(noise-mean(noise))./std(noise);
auto1=xcorr(noise,noise);
auto1=(auto1-min(auto1))./(max(auto1)-min(auto1));
value=auto1(n-2)-auto1(1);
s=100; %step size
counter=0;

while (abs(value)>0.001 || counter > 1000)
    l=l-s*value;
    k=12*pi^2*eta*1.5e-6*l;
for i=1:n-1
noise(i)=-6*pi*eta*1.5e-6*(data(i+1)-data(i))*Fs-k*data(i);
end
counter=counter+1;
noise(n)=0;
noise=(noise-mean(noise))./std(noise);
auto1=xcorr(noise,noise);
auto1=(auto1-min(auto1))./(max(auto1)-min(auto1));
value=auto1(n-2)-auto1(1);
ans1=value;
ans2=l;
end

fprintf("The corner frequency is %f \n",ans2);
