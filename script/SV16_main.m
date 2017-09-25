%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Main

clc 
clear all
close all
rng(42)

%%%%%% Parameters
global S tau0 mu_tau sigma_tau tau_min tau_max a_r_tau0 E_r k r A m thresh_min
S=60 %number of species (60 for SV)
%Temperature-related
tau0=293; %reference temperature in Kelvin (SV)
mu_tau=293; %mean temperature in Kelvin SV
sigma_tau=5; %standard deviation of temperature in Kelvin SV
tau_min=10+273.15; %minimum thermal optimum SV, in Kelvin
tau_max=30+273.15; %maximum thermal optimum SV, in Kelvin
%Growth-related
niche_area=10^3.1/365.25; %SV (... why?)
b0=9;
a_r_tau0 = 386/365.25; %normalization constant for growth rate at reference temperature SV (kg/(kg*year))
E_r=0.467; %eV, activation energy
k=8.6173324*10^(-5); %Boltzmann's constant in eV.K-1
%Other
alpha_compet=0.001; %area/kg (SV) Strength of competition for all individuals
A=ones(S,S)*alpha_compet; %interaction matrix
m=15/365.25; %mortality rate SV (kg/(kg*year))
thresh_min=10^(-6); %species considered extinct below this biomass


%%%%%% Initialize
% Time resolution
tstart = 1.0;
tstop = 5000.0; %5000 years in SV, with 1 day intervals
tsampling = (tstop-tstart)*365+1; 
tspan=linspace(tstart,tstop,tsampling);                        % timespan for the numerical solution


iter=1
% Seasonality with time
tau=compute_temperature(tspan); %this function gives the corresponding temperature of the day. Can be random (as in SV 2016), or based on a seasonal function (as in Taylor et al. 2013 + Sauve&Barraquand) 

%%randomize
tau_mat=zeros(S,length(tau));
for i=1:S
    tau_mat(i,:)=tau(randperm(length(tau)));
end;

%Initialize species time optima
%SV use uniformly spaces thermal optima
tau_opt=linspace(tau_min,tau_max,S); %maybe do another, more realistic function later on, with a normal distribution, maybe, or hot vs. cold-tolerant species (bimodal distribution)
%tau_opt=linspace(17.+273.15,23+273.15,S); %maybe do another, more realistic function later on, with a normal distribution, maybe, or hot vs. cold-tolerant species (bimodal distribution)

%We want to standardize b
fun=@(x,b,tau_opt) growth_response(x).*frac_max(x,tau_opt,b);
b=zeros(1,S);
r=zeros(S,length(tau));
for i=1:S
    tau_opt_i=tau_opt(i);
    b(i)=fminsearch(@(b) abs(integral(@(x) fun(x,b,tau_opt_i),tau_min,tau_max)-niche_area),b0);
%    r(i,:)=fun(tau,b(i),tau_opt_i);
    r(i,:)=fun(tau_mat(i,:),b(i),tau_opt_i);
end;

%figure_1(b,tau_opt);


%%%%%%%%%%%%%%
% t_tmp=1:10000000;
% b_tmp=linspace(1,10^8,length(t_tmp));
% plou=zeros(1,length(t_tmp));
% tau_opt_i=300;
% for i=1:length(t_tmp)
%     plou(i)=integral(@(x) fun(x,b_tmp(i),tau_opt_i),tau_min,tau_max);
% end;
% plot(b_tmp,plou)
% 
% %Initial density
 y0=ones(1,S)*1/(alpha_compet*S);
% 
%%%%%% Integration starts
options= odeset('Reltol',1e-3,'NonNegative',[1 2]);
[tout,yout] = ode45(@SV16_ode_integration, tspan , y0,options);       % ode solver 
%plot(tout,log10(yout))
imin=(tstop-205)*365;
imax=(tstop-1)*365;
figure; hold on;
plot(tout(imin:imax),log10(yout(imin:imax,:)))
hold off;

T=table([transpose(imin:imax) yout(imin:imax,:)]);
writetable(T,strcat(num2str(iter),'essai.txt'))
