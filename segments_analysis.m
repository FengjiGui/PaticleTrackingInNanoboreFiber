clc;clear;
T=dlmread('x:\xxx\data.txt');%  load the data list of the trajectory
nf=500;                     %  choose the length of the sub-trajectory, in the manuscript, nf=[100 200 500 1000 2000 5000 10000 20000 50000 100000];
ft=0.0004032;                %  frame time 
kb =1.3807e-23;              %  Boltzmann constant
Tem=293.15;                  %  room temperature
eta=1e-3;                    %  viscosity of water
lag=2;                       %  lags in MSD
m=0;
j=0;
for n=1:nf:(100000-nf+1)
    m=m+1;
        x=T(n:n+nf-1,2);
x=x*72.6e-9;                 % pixel to space length [m]
N0=length(x);
for k=1:lag
    lag_time(k)=ft*k;
    sqx=x(1:N0-k)-x(k+1:N0);
    msd(k)=mean(sqx.^2); 
end
par=polyfit(lag_time,msd,1);     %  linear fitting to MSD
D_fit(m)=0.5*par(1);             %  diffusion coeficient 
a(m)=kb*Tem/(6*pi*eta*D_fit(m)); %  hydrodynamic radius     
end;  

%%%%%%%%%%%%%%%   hindrance correction
Rc=280e-9;                     %  radius of the nanobore 
for i=1:length(a);
fun_z = @(gx) hindrance_factor_function(gx,Rc)-a(i);
dz_correct(i)=2*fzero(fun_z,30e-9);
end
dz_correct=dz_correct(find(~isnan(dz_correct)));
figure
subplot(1,2,1)                % Figure 4(a) in the manuscript
plot((1:length(D_fit))*ft*nf,D_fit*1e12,'-o','MarkerSize',5);hold on;
xlim([0, length(D_fit)*ft*nf])
xlabel('time[s]'); 
ylabel('D[um^2/s]');
subplot(1,2,2)                % Figure 4(b) in the manuscript
hist(dz_correct*1e9,10)
xlabel('diameter [nm]'); 
ylabel('counts');

%%%%%%%%%%%%%%% The data points in Figure 5(a) and (b)
std_d=std(dz_correct*1e9)       % standard deviation of the hindrance corrected diameter 
avg_d=mean(dz_correct*1e9)      % mean value of the hindrance corrected diameter 
std_D=std(D_fit)                % standard deviation of the measured D 
avg_D=mean(D_fit)               % mean value of the measured D
std_D/avg_D                     % relative standard deviation of the measured D

