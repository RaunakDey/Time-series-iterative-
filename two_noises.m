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
fc=130;
td=1/(2*pi*fc);
kb=1.38e-23;
T=300;
D=kb*T/gamma;
k=2*pi*fc*gamma;

dt=0.0001;


%OU noise generated
lambda=zeros(1,n);
time=zeros(1,n);
for i=2:n
    lambda(i)=lambda(i-1)+dt*(-lambda(i-1)/to)+sqrt(2*A*dt)*r(i-1);
     time(i)=time(i-1)+dt;
end

plot(lambda)
combined=lambda+sqrt(2*D*dt)*r2*(td/dt);


Fs = 1/dt;

tau=(0:100)*dt;
correlation=xcorr(combined,combined)/n;

figure(8)
plot((0:4:100)*dt,correlation(n:4:n+100),'-bo')
hold on;
plot(tau,A*to*exp(-tau/to),'r')
