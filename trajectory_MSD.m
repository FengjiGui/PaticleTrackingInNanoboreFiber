clc;clear;
T=dlmread('x:\xxx\data.txt');%  load the data list of the trajectory
x=T(:,2)*72.6e-9;            %  z-position of the trajectory
N0=length(x);
x1=x(1:N0-1)-x(1+1:N0);      % lag=1;
x10=x(1:N0-10)-x(10+1:N0);    % lag=10;
x20=x(1:N0-20)-x(20+1:N0);    % lag=20; 
figure                       % Figure 2(b) in the manuscript
histogram(x1*1e6,40,'FaceAlpha',0.4,'EdgeAlpha',0.4);hold all;
histogram(x10*1e6,50,'FaceAlpha',0.4,'EdgeAlpha',0.4);
histogram(x20*1e6,60,'FaceAlpha',0.4,'EdgeAlpha',0.4);
xlabel('z-displacement [um]'); 
ylabel('counts');
legend('lag=1','lag=10','lag=20'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%

ft=0.0004032;                %  frame time
kb =1.3807e-23;              %  Boltzmann constant
Tem=293.15;                  %  room temperature
eta=1e-3;                    %  viscosity of water
lag=12;                      %  lags in MSD
for k=1:lag
    lag_time(k)=ft*k;
    sqx=x(1:N0-k)-x(k+1:N0);
    msd(k)=mean(sqx.^2); %%%%%%%%%%%%%  MSD4.3736882181431e-08  4.90953408505219e-12     -7.51677426692658e-15
end
par=polyfit(lag_time(1:2),msd(1:2),1);%  linear fitting to MSD with the first 2 points
D_fit=0.5*par(1);
a=kb*Tem/(6*pi*eta*D_fit);
figure                        % Figure 3(a) in the manuscript
t=0:0.00001:lag_time(end);
plot(lag_time,msd,'o','MarkerSize',5);hold on;
plot(t,par(1)*t+par(2),'-','linewidth',1.5);hold on;
xlabel('lag time (s)'); 
ylabel('<z^2> (m^2)');
legend('data points','fitting'); 
