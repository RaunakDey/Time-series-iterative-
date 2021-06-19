% A and to, gamma known, find k 
% this code does not works

clc;
clear all;

%%%%% parameter defined %%%%%
n=100e4; %number of data points
r=randn(1,n);
r2=randn(1,n);
to=0.0025;
A=0.3*(0.6e-6)^2;



%%% parameters %%%
eta=89e-5;
a=1.5e-6;
gamma=6*pi*eta*a;
fc=50;
td=1/(2*pi*fc);
kb=1.38e-23;
T=300;
D=kb*T/gamma;
k=2*pi*fc*gamma;

dt=0.0001;


%OU noise generated
lambda=zeros(1,n);
for i=2:n
    lambda(i)=lambda(i-1)+dt*(-lambda(i-1)/to)+sqrt(2*A*dt)*r(i-1);
end

%position simulated
x_pos=zeros(1,n);
time=zeros(1,n);
x_pos(1)=0;
for i=2:n
   x_pos(i)=x_pos(i-1)+dt*(-(x_pos(i-1)-lambda(i-1))/td)+sqrt(2*D*dt)*r2(i-1); 
   time(i)=time(i-1)+dt;
end


data=x_pos-mean(x_pos);
Fs = 1/dt;

%%

tau=(0:100)*dt;
dummy=zeros(1,length(tau));
dummy(1)=1;
 j=1;  
 
for A=[0.1,0.2,0.3,0.4,0.5]*(0.6e-6)^2
    j
for l=1:150
k=12*pi^2*eta*1.5e-6*l;
td=1/(2*pi*l);

for i=1:n-1
noise(i)=-6*pi*eta*1.5e-6*(data(i+1)-data(i))*Fs-k*(data(i));
end
noise(n)=0;

correlation=xcorr(noise,noise)/n;
corr_trim=correlation(n:end);

err=corr_trim(1:101)-k^2*A*to*exp(-tau/to)+k^2*dummy*(2*D*dt)*(td/dt)^2;
error(l,j)=sum(abs(err));
end
j=j+1;
end

