%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% This script is nearly the same as a main SV, but is used to test the
%%% effect of concatenating several simulations in order to have long ones.
%%% Indeed, a 15000 year simulation need a 15 000*365*60 growth rate
%%% vector, which considerably slows down the integration process. If we
%%% could do 5000 + 5000 + 5000, would be great

%Ok, SO. At the end of ONE simulation, we have the same number of species
%and the same species... but not the same abundance and not exactly the
%same RAC. I prefer to stick to long simulations done in one piece. 

close all; clear all; clc;
dir_output="test";

global S tau0 mu_tau sigma_tau tau_min tau_max a_r_tau0 E_r k A m thresh_min tspan tau b tau_opt r

S=60 %number of species (60 for SV)

%Temperature-related
tau0=293; %reference temperature in Kelvin (SV)
mu_tau=293; %mean temperature in Kelvin SV
sigma_tau=5; %standard deviation of temperature in Kelvin SV
%theta=sqrt(2)-eps(sqrt(2)); %just to avoid complex values due to machine imprecision
theta=0

    %%%%%% Initialize
% Time resolution
tstart = 1.0;
tstop = 15000*365; %5000 years in SV, with 1 day intervals %15 000 used here to test for convergence
tsampling = (tstop-tstart)+1; 
tspan=linspace(tstart,tstop,tsampling);                        % timespan for the numerical solution
%%% Necessary only if we're computing another signal, not loading
%%% temperature from a previous simulation
tau=compute_temperature_season(tspan, theta); 

tau_min=15+273; %minimum thermal optimum SV, in Kelvin
tau_max=25+273; %maximum thermal optimum SV, in Kelvin
%Growth-related
niche_area=(10^3.1)/365; %SV (... why?)
b0=9;
a_r_tau0 = 386/365; %normalization constant for growth rate at reference temperature SV (kg/(kg*year))
E_r=0.467; %eV, activation energy
k=8.6173324*10^(-5); %Boltzmann's constant in eV.K-1
tau_opt=linspace(tau_min,tau_max,S);

%Other
alpha_compet=0.001; %area/kg (SV) Strength of competition for all individuals
A=ones(S,S)*alpha_compet;%+diag(ones(60,1)*alpha_compet*9); %interaction matrix

m=15/365; %mortality rate SV (kg/(kg*year))
thresh_min=10^(-6); %species considered extinct below this biomass
yspan=200;
ysave=500;

%We want to standardize b
fun=@(x,b,tau_opt) growth_response(x).*frac_max(x,tau_opt,b);
b=zeros(1,S);
for i=1:S
    tau_opt_i=tau_opt(i);
    b(i)=fminsearch(@(b) abs(integral(@(x) fun(x,b,tau_opt_i),tau_min-5,tau_max+5)-niche_area),b0);
end;

options= odeset('AbsTol',1e-8, 'RelTol',1e-3,'NonNegative',1:60);


%%%First simulation, using all 
 y0=ones(1,S)*1/(alpha_compet*S);
 r=zeros(S,length(tau));
for i=1:S
     r(i,:)=fun(tau,b(i),tau_opt(i));   
end;
[tout,yout] = ode45(@SV16_ode_integration, tspan , y0,options);       % ode solver
nb_species_first_case=sum(yout'>thresh_min);


tstop=size(yout,1);
imin=tstop-ysave*365+1;
imax=tstop;
youtbis=yout(imin:imax,:);
final_community_first_case=youtbis(end,:);

clear r tout yout

%Second set of simulations
tau1=tau(1:(5000*365));
tau2=tau((5000*365+1):(10000*365));
tau3=tau((10000*365+1):end);

tspan1=tspan(1:(5000*365));
tspan2=tspan((5000*365+1):(10000*365));
tspan3=tspan((10000*365+1):end);

 r=zeros(S,length(tau1));
for i=1:S
     r(i,:)=fun(tau1,b(i),tau_opt(i));   
end;
[tout1,yout1] = ode45(@SV16_ode_integration, tspan1 , y0,options);       % ode solver
nb_species_second_case1=sum(yout1'>thresh_min);
clear r tout1

 y0=yout1(end,:);
 r=zeros(S,length(tau2));
for i=1:S
     r(i,:)=fun(tau2,b(i),tau_opt(i));   
end;
[tout2,yout2] = ode45(@SV16_ode_integration, tspan2 , y0,options);       % ode solver
nb_species_second_case2=sum(yout2'>thresh_min);

clear r tout2

 y0=yout2(end,:);
 r=zeros(S,length(tau3));
for i=1:S
     r(i,:)=fun(tau3,b(i),tau_opt(i));   
end;
[tout3,yout3] = ode45(@SV16_ode_integration, tspan3 , y0,options);       % ode solver

nb_species_second_case3=sum(yout3'>thresh_min);
nb_species_second_case=[nb_species_second_case1 nb_species_second_case2 nb_species_second_case3];
final_community_second_case=yout3(end,:);

tstop=size(yout3,1);
imin=tstop-ysave*365+1;
imax=tstop;
youtbis3=yout3(imin:imax,:);


save(strcat('./output_simulation/',dir_output,'/','test_concatenate_codeversion_20180228_theta0.mat'),'youtbis','youtbis3','nb_species_first_case','nb_species_second_case','final_community_second_case','final_community_first_case')
