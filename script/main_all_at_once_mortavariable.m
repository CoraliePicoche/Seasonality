%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% This scrpipt integrates the species dynamics with 4 different set of
%%% coexistence mechanisms, and 2 different types of noise

clc 
clear all
close all

%%%%%% Parameters
global S tau0 mu_tau sigma_tau tau_min tau_max a_r_tau0 E_r k A m thresh_min tspan r morta_vect

S=60 %number of species
%Temperature-related
tau0=293; %reference temperature in Kelvin
mu_tau=293; %mean temperature in Kelvin
sigma_tau=5; %standard deviation of temperature in Kelvin
tau_min=15+273; %minimum thermal optimum, in Kelvin
tau_max=25+273; %maximum thermal optimum, in Kelvin

%Growth-related
niche_area=(10^3.1)/365;
b0=9; %Initialize the optimization process to compute species-specific b
a_r_tau0 = 386/365; %normalization constant for growth rate at reference temperature (kg/(kg*year))
E_r=0.467; %eV, activation energy
k=8.6173324*10^(-5); %Boltzmann's constant in eV.K-1

%Other
alpha_compet=0.001; %area/kg Strength of competition for all individuals
m=15/365; %mortality rate (kg/(kg*year))
m_var=0.1/365; % slighlty variable mortality rate (set to 0 in the article's simulations; this is for the Electronic Supplementary Material
thresh_min=10^(-6); %species considered extinct below this biomass
yspan=200; %We don't keep all years
ysave=500;

%My addition
rho=10; %proportionality between intra and intergroup coefficient : \alpha_{ii}=rho * \alpha_{ij} ; strong self-regulatotion
options= odeset('AbsTol',1e-8, 'RelTol',1e-3,'NonNegative',1:60); %Option for integration

%%%%%% Initialize
% Time resolution
tstart = 1.0;
tstop = 5001.0*365; 
tsampling = (tstop-tstart)+1; 
tspan=linspace(tstart,tstop,tsampling);                        % timespan for the numerical solution
 imin=tstop-ysave*365+1; %indices for the days we keep
 imax=tstop; 

%Initialize species time optima
%Uniformly spaced thermal optima
tau_opt=linspace(tau_min,tau_max,S); 

%We want to standardize b
fun=@(x,b,tau_opt) growth_response(x).*frac_max(x,tau_opt,b);
b=zeros(1,S);
for i=1:S
    tau_opt_i=tau_opt(i);
    b(i)=fminsearch(@(b) abs(integral(@(x) fun(x,b,tau_opt_i),tau_min-5,tau_max+5)-niche_area),b0);
end;

%Random or seasonal noise depends on the value of theta
theta=[0 1.3];
dir_output={'white_noise/morta_variable/','season/morta_variable/'};
 
for cond=1:2
 theta(cond)
 dir_output{cond}
for iter=1:100
    rng(iter)
    iter
% Seasonality with time
tau=compute_temperature_season(tspan, theta(cond)); %this function gives the corresponding temperature of the day. Can be random (as in SV 2016), or based on a seasonal function (as in Taylor et al. 2013 + Sauve&Barraquand, unpublished) 
morta_vect= (-1 + (1+1)*rand(S,1))*m_var+m

r=zeros(S,length(tau));
for i=1:S
     r(i,:)=fun(tau,b(i),tau_opt(i));   
end;


%First case : original model +SE-SSR
%between intra and intergroup coefficient
 y0=ones(1,S)*1/(alpha_compet*S);
 A=ones(S,S)*alpha_compet; %interaction matrix

tspan_bis=[tstart tspan(imin:imax)];

%%%%%% Integration starts
[toutbis,youtbis] = ode45(@SV16_ode_integration, tspan_bis , y0,options);       % ode solver
nb_species=sum(youtbis'>thresh_min);
nb_species(end)
save(strcat('./output_simulation/',dir_output{cond},'/','iter',num2str(iter),'_codeversion_20180228.mat'),'toutbis','youtbis','tau_opt','b','tau','nb_species','A','morta_vect');
clear toutbis youtbis nb_species;

%Second case : +SE+SSR
 y0=ones(1,S)*1/(alpha_compet*S);
 A=ones(S,S)*alpha_compet+diag(ones(60,1)*alpha_compet*(rho-1)); %interaction matrix

%%%%%% Integration starts
[toutbis,youtbis] = ode45(@SV16_ode_integration, tspan_bis , y0,options);       % ode solver
nb_species=sum(youtbis'>thresh_min);
nb_species(end)
save(strcat('./output_simulation/',dir_output{cond},'/','iter',num2str(iter),'_codeversion_20180228_10higher.mat'),'toutbis','youtbis','tau_opt','b','tau','nb_species','A','morta_vect');
clear toutbis youtbis nb_species;

%Third case : -SE-SSR
 y0=ones(1,S)*1/(alpha_compet*S);
 A=ones(S,S)*alpha_compet;
 tmp_r=mean(r,2);
 A=tmp_r.*A;

%%%%%% Integration starts
[toutbis,youtbis] = ode45(@SV16_ode_integration_no_GR_in_competition, tspan_bis , y0,options);       % ode solver
nb_species=sum(youtbis'>thresh_min);
nb_species(end)
save(strcat('./output_simulation/',dir_output{cond},'/','iter',num2str(iter),'_codeversion_20180228_noforcedcompetition_weightedinteraction.mat'),'toutbis','youtbis','tau_opt','b','tau','nb_species','A','morta_vect');
clear toutbis youtbis nb_species;

%Fourth case : -SE+SSR
 y0=ones(1,S)*1/(alpha_compet*S);
 A=ones(S,S)*alpha_compet+diag(ones(60,1)*alpha_compet*(rho-1)); 
 A=tmp_r.*A;

%%%%%% Integration starts
[toutbis,youtbis] = ode45(@SV16_ode_integration_no_GR_in_competition, tspan_bis , y0,options);       % ode solver
nb_species=sum(youtbis'>thresh_min);
nb_species(end)
save(strcat('./output_simulation/',dir_output{cond},'/','iter',num2str(iter),'_codeversion_20180228_noforcedcompetition_10higherintra_weightedinteraction.mat'),'toutbis','youtbis','tau_opt','b','tau','nb_species','A','morta_vect');
clear tau r toutbis youtbis nb_species;

end;

end;