function [x,AR,gamma_s,gamma_p,tau,dt] = VE_brow2(k,T,a0,eta_s,eta_p,tau)
%simulation of Brownian motion in VE Jeffrey fluid
%   Detailed explanation goes here
%%
%%%parameters
%k=1e-6 ; % trap stiffness
kb=1.38e-23/1e-12 ; % Boltzmann konstant in mu m length scale
%T=300; %temperature
a0=a0/1e-6; %particle radius mu m
%eta_s=eta_s; %fluid viscosity mu m
%eta_p=eta_p; %polymer viscosity mu m
%tau=10;     %polymer time constant
gamma_s=6*pi*eta_s*a0;  % fluid friction coeff.
gamma_p=6*pi*eta_p*a0;  % polymer friction coeff.




dt=0.01;  % sampling time interval
Time=1000;    % total sampling time  

N=round(Time/dt);     % Number of data points



%D11=0.1;
%D22=0.2;

%%%process AR coeff.
lamda11=(k/gamma_s + gamma_p/gamma_s/tau);
lamda12=-gamma_p/gamma_s/tau;
lamda21=-1/tau;
lamda22=1/tau;

lamda=[lamda11 lamda12;lamda21 lamda22];

AR=expm(-lamda.*dt);
AR11=AR(1,1);
AR12=AR(1,2);
AR21=AR(2,1);
AR22=AR(2,2);

%%%process covariance
sigma=(kb*T/k).*[1 1;1 (1 + k*tau/gamma_p)];


%%
%%%simulation of Brownian motion 

c=[0; 0];  %%offset

covariance=sigma - (AR*sigma*AR');
covariance(1,2)=covariance(2,1);   %% To avoid numerical precision error
AR1={[AR11 AR12;AR21 AR22]};

Mdl = varm('Constant',c,'AR',AR1,'Covariance',covariance);

x0=[0 0];  %initialization
x = simulate(Mdl,N,'Y0',x0);

end

