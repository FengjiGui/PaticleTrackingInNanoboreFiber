clc;
clear;
for n_simu=1:3000                               % 3000 times simulations     
%%%%%%%%%%%% produce data by random walk
kb =1.3807e-23;
Tem=293.15;
eta=1e-3; 
a=3.6e-08;                                     % hydrodiameter
D=kb*Tem/(6*pi*eta*a);                         % diffusion coefficient
ft=0.0004032;                                  % frame rate=1/dt
te=0.0002;                                     % exposure time
m=100;                                         % micro steps in an exposure time   
q=floor(te/ft*m);
delta_t=ft/m;                       
s0=0.21*532e-9/1.25;
sgm=sqrt(1+D*te/s0^2)*s0/sqrt(8.5*90000);      %localization uncertainty     
sigma0=sqrt(2*D*delta_t);
n_frame=100000;                                %frames number
x0=0;y0=0;                                     %initial position
mu0=x0;
x=[];
dx=[];
for j=1:n_frame;
rndx= sigma0.*randn(1,m-1);
x(j)=mu0+sum((q-(1:q-1))/q.*rndx(1:q-1));
mu0=mu0+sum(rndx);
end;
for j=1:n_frame;
dx(j)=sgm*randn(1,1);
end;
x=x+dx;
data_x=x';
%%%%%%%%%%%%%%%%%% segments analysis
T=data_x;
m=0;
j=0;
nf0=[100,200,500,1000,2000,5000,10000,25000,50000];
for count_nf=1:length(nf0) 
a=[];
dz_correct=[];
m=0;
j=0;
nf=nf0(count_nf);
for n=1:nf:(100000-nf+1)
m=m+1;
x=T(n:n+nf-1,1);
N0=length(x);
kb =1.3807e-23;
Tem=293.15;
eta=1e-3; 
lag=2;
for k=1:lag
    lag_time(k)=ft*k;
    sqx=x(1:N0-k)-x(k+1:N0);
    msd(k)=mean(sqx.^2); 
end
par=polyfit(lag_time,msd,1);
D_fit(m)=0.5*par(1);
a(m)=kb*Tem/(6*pi*eta*D_fit(m));
end;
D_correct=kb*Tem./(6*pi*eta*a);
std_D(n_simu,count_nf)=std(D_correct);
avg_D(n_simu,count_nf)=mean(D_correct);
end;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%% to get the simulation results in Fig.5(b)
rel=std_D./avg_D;
 for i=1:length(nf0)
    avg_rel_D(i)=mean(rel(:,i));
    std_rel_D(i)=std(rel(:,i));
end
plus=(avg_rel_D+std_rel_D)';
minu=(avg_rel_D-std_rel_D)';
loglog(nf0,avg_rel_D');hold on;
loglog(nf0,minu);hold on;
loglog(nf0,plus);hold on
xlabel('N_f');
ylabel('relative error of ¦ÄD')