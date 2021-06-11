
function x_pos=simu(fc,eta,n,dt)

r2=randn(1,n);
a=1.5e-6;
gamma=6*pi*eta*a;
td=1/(2*pi*fc);
kb=1.38e-23;
T=300;
D=kb*T/gamma;
k=2*pi*fc*gamma;

%position simulated
x_pos=zeros(1,n);
time=zeros(1,n);
x_pos(1)=0;
for i=2:n
   x_pos(i)=x_pos(i-1)+dt*(-(x_pos(i-1))/td)+sqrt(2*D*dt)*r2(i-1); 
   time(i)=time(i-1)+dt;
end

end 





