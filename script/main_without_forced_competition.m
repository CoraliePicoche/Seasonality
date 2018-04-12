%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Same structure as Main, but with two teaks: we take the environmental
%%% conditions used in previous simulations (1) to model the dynamics with
%%% all things equal, but with no effect of the temperature on interaction
%%% strengths (2)

close all; clear all; clc;
dir_output="no_forced_competition";

global S tau0 mu_tau sigma_tau tau_min tau_max a_r_tau0 E_r k A m thresh_min tspan tau b tau_opt r

S=60 %number of species (60 for SV)

%Temperature-related
tau0=293; %reference temperature in Kelvin (SV)
mu_tau=293; %mean temperature in Kelvin SV
sigma_tau=5; %standard deviation of temperature in Kelvin SV
%theta=sqrt(2)-eps(sqrt(2)); %just to avoid complex values due to machine imprecision
theta=0
%%% Necessary only if we're computing another signal, not loading
%%% temperature from a previous simulation
%tau=compute_temperature_season(tspan, theta); 

tau_min=15+273; %minimum thermal optimum SV, in Kelvin
tau_max=25+273; %maximum thermal optimum SV, in Kelvin
%Growth-related
fun=@(x,b,tau_opt) growth_response(x).*frac_max(x,tau_opt,b);
a_r_tau0 = 386/365; %normalization constant for growth rate at reference temperature SV (kg/(kg*year))
E_r=0.467; %eV, activation energy
k=8.6173324*10^(-5); %Boltzmann's constant in eV.K-1

%Other
alpha_compet=0.001; %area/kg (SV) Strength of competition for all individuals
A=ones(S,S)*alpha_compet+diag(ones(60,1)*alpha_compet*9); %interaction matrix
% %Here, I'm trying Ashby et al. (2017) formulation
% for i=1:S
%     for j=1:S
%         A(i,j)= alpha_compet*10*integral(@(x)fun(x,b(i),tau_opt(i)).*fun(x,b(j),tau_opt(j)),10+273,30+273)/integral(@(x)(fun(x,b(i),tau_opt(i))).^2,10+273,30+273);
%     end;
% end;
% %max(eig(A))=0.23
% %Factor 10*alpha_compet is there to keep the same maximum value of competition
% %intra-group

m=15/365; %mortality rate SV (kg/(kg*year))
thresh_min=10^(-6); %species considered extinct below this biomass
yspan=200;
ysave=500;

for iter=2:10
    iter
    load(strcat('./output_simulation/SV_same_temp/iter',num2str(iter),'_codeversion_20180228_theta0.mat'));
    %%%%%% Initialize
% Time resolution
tstart = 1.0;
tstop = length(tau); %5000 years in SV, with 1 day intervals %15 000 used here to test for convergence
tsampling = (tstop-tstart)+1; 
tspan=linspace(tstart,tstop,tsampling);                        % timespan for the numerical solution
 y0=ones(1,S)*1/(alpha_compet*S);

    r=zeros(S,length(tau));
     for i=1:S
         r(i,:)=fun(tau,b(i),tau_opt(i));   
     end;
%Here, we can weigh the competition coefficients by the mean growth rate
%    tmp_r=mean(r,2);
%    A=tmp_r.*A;
%%%
    options= odeset('AbsTol',1e-8, 'RelTol',1e-3,'NonNegative',1:60); %NonNegative is necessary and speaking to Alix indicated that Reltol and Absol can be changed quite safely. For

    [tout,yout] = ode45(@SV16_ode_integration_no_GR_in_competition, tspan , y0,options);       % ode solver
     imin=tstop-ysave*365+1;
    imax=tstop;

    toutbis=tout(imin:imax);
    youtbis=yout(imin:imax,:);
    nb_species=sum(yout'>thresh_min);
    nb_species(end)
    save(strcat('./output_simulation/',dir_output,'/','iter',num2str(iter),'_codeversion_20180228_theta0_noforcedcompetition_10higherintra.mat'),'toutbis','youtbis','tau_opt','b','tau','nb_species');
end;
    