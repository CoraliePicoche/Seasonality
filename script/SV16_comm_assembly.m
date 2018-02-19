%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Main for community assembly

clc 
clear all
close all
dir_output='invasion';

%%%%%% Parameters
global S tau0 mu_tau sigma_tau tau_min tau_max a_r_tau0 E_r k A m thresh_min tspan r invasion_time
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
ysave=200;
mean_invasion_time=20*365;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WORK

%%%%%% Initialize
% Time resolution
tstart = 1.0;
tstop = 10001.0*365; %5000 years in SV, with 1 day intervals
tsampling = (tstop-tstart)+1; 
tspan=linspace(tstart,tstop,tsampling);                        % timespan for the numerical solution
distrib_invasion=makedist('Exponential','mu',mean_invasion_time);

%Initialize species time optima
%SV use uniformly spaces thermal optima
tau_opt=linspace(tau_min,tau_max,S); %maybe do another, more realistic function later on, with a normal distribution, maybe, or hot vs. cold-tolerant species (bimodal distribution)

%We want to standardize b
fun=@(x,b,tau_opt) growth_response(x).*frac_max(x,tau_opt,b);
b=zeros(1,S);
for i=1:S
    tau_opt_i=tau_opt(i);
    b(i)=fminsearch(@(b) abs(integral(@(x) fun(x,b,tau_opt_i),tau_min-5,tau_max+5)-niche_area),b0);
end;


S_invade=1:60; % to be in the range that seems to survive in fig. from SV

 for iter=3:100
     tstart = 1.0;
tstop = 10001.0*365; %5000 years in SV, with 1 day intervals
tsampling = (tstop-tstart)+1; 
tspan=linspace(tstart,tstop,tsampling);                        % timespan for the numerical solution

rng(iter)
iter
% Seasonality with time
tau=compute_temperature(tspan); %this function gives the corresponding temperature of the day. Can be random (as in SV 2016), or based on a seasonal function (as in Taylor et al. 2013 + Sauve&Barraquand) 
invasion_time=random(distrib_invasion,1);
while sum(invasion_time)<tstop
    invasion_time=[invasion_time random(distrib_invasion,1)];
end
invasion_time=floor(cumsum(invasion_time));
list_species=zeros(length(invasion_time),1);

r=zeros(S,length(tau));
for i=1:S
    r(i,:)=fun(tau,b(i),tau_opt(i));
end;

 
%for s_first=S_invade
     y0=zeros(1,S);
    s_first=randi([S_invade(1) S_invade(end)],1);

    y0(s_first)=1/(alpha_compet*2)
 
tstart=1.0;
tout = 1.0;
yout = y0;
teout = [];
yeout = [];
ieout = [];

options= odeset('Reltol',1e-3,'NonNegative',1:60);
tstop_tmp=min(invasion_time(1),tstop);
for j=1:length(invasion_time)
       tstop_tmp=min(invasion_time(j),tstop);
       tspan=linspace(tstart,tstop_tmp,tstop_tmp-tstart+1.0);
% 
%tried to work with events 
%tried to work with ode15s
%%%%%% Integration starts
if length(tspan)>1
    [t,y] = ode45(@SV16_ode_integration, tspan , y0,options);       % ode solver
end;
   % Accumulate output.  This could be passed out as output arguments.
   nt = length(t);
   tout = [tout; t(2:nt)];
   yout = [yout; y(2:nt,:)];
   y0 = y(nt,:);
   choose_species=randi([S_invade(1) S_invade(end)],1);
   list_species(j)=choose_species;
   if y0(choose_species)<thresh_min
      % y0(choose_species)=1/(alpha_compet*2);
       y0(choose_species)=thresh_min;
   end
   
   tstart = t(nt);
end


 imin=max(1,length(tout)-ysave*365);
 imax=length(tout);


%T=table([tout(imin:imax) yout(imin:imax,:)]); %I can't save everything, so I'm just saving what I'll need afterwards
%T2=table([tau_opt; b]);
toutbis=tout(imin:imax);
youtbis=yout(imin:imax,:);
mask=youtbis(end,:)

save(strcat('./output_simulation/',dir_output,'/random_init_iter_',num2str(iter),'ode45_no_refine_low_initial_density_minimal_value.mat'),'toutbis','youtbis','tau_opt','b','tau','invasion_time','list_species');
%writetable(T2,strcat('./output_simulation/SV_same_temp/',num2str(iter),'essai_param.txt'))
%end;
end;


