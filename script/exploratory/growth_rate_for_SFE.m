%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
% Graph showing growth rate for SFE poster

clear all; close all; clc;
global S tau0 mu_tau sigma_tau tau_min tau_max a_r_tau0 E_r k A m thresh_min tspan r

afontsize=15;

S=60 %number of species (60 for SV)
col=jet(60);
%Temperature-related
tau0=293; %reference temperature in Kelvin (SV)
mu_tau=293; %mean temperature in Kelvin SV
sigma_tau=5; %standard deviation of temperature in Kelvin SV


tau_min=15+273; %minimum thermal optimum SV, in Kelvin
tau_max=25+273; %maximum thermal optimum SV, in Kelvin
tmp_tot=linspace(tau_min,tau_max,1000);

%Growth-related
niche_area=(10^3.1)/365; %SV (... why?)
b0=9;
a_r_tau0 = 386/365; %normalization constant for growth rate at reference temperature SV (kg/(kg*year))
E_r=0.467; %eV, activation energy
k=8.6173324*10^(-5); %Boltzmann's constant in eV.K-1


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
r=growth_response(tmp_tot);

S_to_show=[10 20 30 40 50];
figure; hold on;
for i=S_to_show
    i
    densr=365*r.*frac_max(tmp_tot,tau_opt(i),b(i));
    plot(tmp_tot-273.15,densr,'-','Color',col(i,:),'LineWidth',3);
end;
   plot(tmp_tot-273.15,365.25*r,'k','LineWidth',3);
ylabel("Intrinsic growth rate (kg/(kg*year))",'Fontsize',afontsize);
xlabel("Temperature (°C)",'Fontsize',afontsize)
set(gca,'Fontsize',afontsize)
xlim([15 25])
   hold off;

   fig=gcf;
   print(fig,'./Pres/growth_rate_SFE','-depsc')