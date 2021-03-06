clc 
clear all
close all
dir_output='invasion';

%%%%%% Parameters
global S tau0 mu_tau sigma_tau tau_min tau_max a_r_tau0 E_r k A m thresh_min tspan r s_invasive
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
mean_invasion_time=20*365;


adir='./output_simulation/SV_same_temp/';
allfiles=dir(adir);
fileNames = {allfiles(~[allfiles.isdir]).name};
f=7; %This is the 'best' (as in 'looking like the paper') example I have
%OR I could average the regular communities, see the 11 ones that are
%present most of the time and only keep the simulations in which you find
%those. I can also do simulate again
%OR I could just loop over a subset of f
load(strcat([adir,fileNames{f}]));
mask=youtbis(end,:)<thresh_min;
sbis=1:S;
sbis=sbis(~mask) %extant species

rng(f)

%%%%%% Initialize
% Time resolution
tstart = 1.0;
tstop = 10001.0*365; %5000 years in SV, with 1 day intervals
middle=5001.0*365;
 imin=tstop-ysave*365;
 imax=tstop;
tsampling = (tstop-tstart)+1; 
tspan=linspace(tstart,tstop,tsampling);
tau=compute_temperature(tspan);

fun=@(x,b,tau_opt) growth_response(x).*frac_max(x,tau_opt,b);
r=zeros(S,length(tau));
for i=1:S
    r(i,:)=fun(tau,b(i),tau_opt(i));
end;

options_no_event= odeset('Reltol',1e-3,'AbsTol',1e-8,'NonNegative',1:60);%,'Refine',1);
options_event= odeset('Reltol',1e-3,'NonNegative',1:60,'Events',@event_is_zero,'Refine',1);

y0=youtbis(end,:);

%Definition of a null model without extinction
%HERE, I should try out stg, what is the difference between the 2 following
%commented lines and, the next one that I use


%      imin=tstop-ysave*365;
%      imax=tstop;
% [tout_null,yout_null] = ode45(@SV16_ode_integration, tspan([1 middle]), y0,options_no_event);
% [tout_null,yout_null] = ode45(@SV16_ode_integration, [tspan(middle+1) imin:imax], yout_null(end,:),options_no_event);
% tout_null_bis=tout_null(2:end);
% yout_null_bis=yout_null(2:end,:);
% 
% save(strcat('./output_simulation/KO/simu',num2str(f),'_null_model_two_parts.mat'),'tout_null_bis','yout_null_bis','tau_opt','b','tau');
% 
% clearvars tout_null yout_null tout_null_bis yout_null_bis;
% 
%      imin=tstop-ysave*365;
%      imax=tstop;
% [tout_null,yout_null] = ode45(@SV16_ode_integration, tspan([1 imin:imax]) , y0, options_no_event);
%      imin=max(1,length(tout_null)-ysave*365);
%      imax=length(tout_null);
% tout_null_bis=tout_null(imin:imax);
% yout_null_bis=yout_null(imin:imax,:);
% save(strcat('./output_simulation/KO/simu',num2str(f),'_null_model.mat'),'tout_null_bis','yout_null_bis','tau_opt','b','tau');
%  
% clearvars tout_null yout_null tout_null_bis yout_null_bis;

%I'm not very satisfied because the one part has lower density thant the
%two parts even though the global variability is maintained


%Then, each extant species is knocked out
for s=sbis
    s
    y0_knocked_out=y0;
    y0_knocked_out(s)=0.0;
    s_invasive=s;
    
    [t,y_1] = ode45(@SV16_ode_integration, tspan([1 middle]), y0_knocked_out, options_no_event);       % ode solver
    %tout = t;
    
    %Species come back to life 
   y0_knocked_out = y_1(end,:);
   
   y0_knocked_out(s)=10^(-5);
   
   save(strcat('./output_simulation/KO/simu',num2str(f),'_KO_',num2str(s),'first_5000_years.mat'),'t','y_1');
  % load(strcat('./output_simulation/KO/simu',num2str(f),'_KO_',num2str(s),'first_5000_years.mat'));
   
   tstart=t(end)+1;
   clearvars y_1 t;
   
   counter=9;
    tstop=tspan(end);
    tsampling = (tstop-tstart)+1; 
    tnew=linspace(tstart,tstop,tsampling);
    [t,y_2,te,ye,ie] = ode45(@SV16_ode_integration, tnew, y0_knocked_out, options_event); 
    nt = t(end);
    
    while counter>0 & length(ie)>0
       % y0_knocked_out=y_2(end,:)
       tstart=t(end)+1;
        tstop=tspan(end);
        tsampling = (tstop-tstart)+1; 
        tnew=linspace(tstart,tstop,tsampling);

       counter=counter-1;
       y0_knocked_out=y_2(end,:);
        y0_knocked_out(s)=10^(-5);
        [t,y_2,te,ye,ie] = ode45(@SV16_ode_integration, tnew, y0_knocked_out, options_event);
        nt = t(end);
    end;
    
    if nt<tspan(end)
               tstart=t(end)+1;
        tstop=tspan(end);
        tsampling = (tstop-tstart)+1; 
        tnew=linspace(tstart,tstop,tsampling);
         [t,y_2,te,ye,ie] = ode45(@SV16_ode_integration, tnew, y2(end,:), options_no_event); 
    end;
    
     imin=max(1,length(t)-ysave*365);
     imax=length(t);
   
    y_2_bis=y_2(imin:imax,:);
    
    save(strcat('./output_simulation/KO/simu',num2str(f),'_KO_',num2str(s),'.mat'),'y_2_bis');
end;
  