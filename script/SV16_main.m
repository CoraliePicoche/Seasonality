%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Main

clc 
clear all
close all


%%%%%% Parameters
global S tau0 mu_tau sigma_tau tau_min tau_max a_r_tau0 E_r k A m thresh_min tspan r
S=60 %number of species (60 for SV)
%Temperature-related
tau0=293; %reference temperature in Kelvin (SV)
mu_tau=293; %mean temperature in Kelvin SV
sigma_tau=5; %standard deviation of temperature in Kelvin SV
tau_min=15+273; %minimum thermal optimum SV, in Kelvin
tau_max=25+273; %maximum thermal optimum SV, in Kelvin
%Growth-related
niche_area=(10^3.1)/365; %SV (... why?)
b0=9;
a_r_tau0 = 386/365; %normalization constant for growth rate at reference temperature SV (kg/(kg*year))
E_r=0.467; %eV, activation energy
k=8.6173324*10^(-5); %Boltzmann's constant in eV.K-1
%Other
alpha_compet=0.001; %area/kg (SV) Strength of competition for all individuals
A=ones(S,S)*alpha_compet; %interaction matrix
m=15/365; %mortality rate SV (kg/(kg*year))
thresh_min=10^(-6); %species considered extinct below this biomass
yspan=200;
ysave=500;


%%%%%% Initialize
% Time resolution
tstart = 1.0;
tstop = 5001.0*365; %5000 years in SV, with 1 day intervals
tsampling = (tstop-tstart)+1; 
tspan=linspace(tstart,tstop,tsampling);                        % timespan for the numerical solution


%Initialize species time optima
%SV use uniformly spaces thermal optima
tau_opt=linspace(tau_min,tau_max,S); %maybe do another, more realistic function later on, with a normal distribution, maybe, or hot vs. cold-tolerant species (bimodal distribution)
%tau_opt=linspace(17.+273,23+273,S);

%We want to standardize b
fun=@(x,b,tau_opt) growth_response(x).*frac_max(x,tau_opt,b);
b=zeros(1,S);
for i=1:S
    tau_opt_i=tau_opt(i);
    b(i)=fminsearch(@(b) abs(integral(@(x) fun(x,b,tau_opt_i),tau_min-5,tau_max+5)-niche_area),b0);
end;


% %Initial density
 y0=ones(1,S)*1/(alpha_compet*S);
 
 
for iter=1:1
    rng(iter)
    iter
% Seasonality with time
tau=compute_temperature(tspan); %this function gives the corresponding temperature of the day. Can be random (as in SV 2016), or based on a seasonal function (as in Taylor et al. 2013 + Sauve&Barraquand) 

%%randomize
tau_mat=zeros(S,length(tau));
for i=1:S
%    if iter<=10
        tau_mat(i,:)=tau;
        dir_output='SV_same_temp';
    else
        tau_mat(i,:)=tau(randperm(length(tau)));
        dir_output='SV_different_temp';
    end;

end;

r=zeros(S,length(tau));
for i=1:S
    r(i,:)=fun(tau_mat(i,:),b(i),tau_opt(i));
end;


%%%%%% Integration starts
options= odeset('Reltol',1e-3,'NonNegative',[1 2]);
[tout,yout] = ode45(@SV16_ode_integration, tspan , y0); %,options);       % ode solver
 imin=tstop-ysave*365;
 imax=tstop;

toutbis=tout(imin:imax);
youtbis=yout(imin:imax,:);
save(strcat('./output_simulation/',dir_output,'/',num2str(iter),'essai.mat'),'toutbis','youtbis','tau_opt','b','tau_mat');
end;