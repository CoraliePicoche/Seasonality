%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Analyse growth rates to reproduce their effect on interaction
%%% coefficients

clear all;
close all;

global a_r_tau0 tau0 E_r k 
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


c=jet(60);
Big_R=zeros(10,3,60);
for iter=1:100
    iter
    load(strcat('./output_simulation/white_noise/iter',num2str(iter),'_codeversion_20180228_theta0.mat'));
        r=zeros(S,length(tau));
     for i=1:S
         r(i,:)=fun(tau,b(i),tau_opt(i));   
     end;
    
   min_r=min(r,[],2);
   max_r=max(r,[],2);
      Big_R(iter,1,:)=max_r;
   sd_r=std(r,[],2);
         Big_R(iter,2,:)=sd_r;
   mean_r=mean(r,2);
         Big_R(iter,3,:)=mean_r;
      
end;


   subplot(3,1,1)
   var_tmp=reshape(Big_R(:,1,:),size(Big_R,1),size(Big_R,3));
    Max=mean(var_tmp,1);
boxplot(var_tmp,'BoxStyle','filled','Colors','k','whisker',1000) %if you want the coloured version, use c for Colors instead of 'k'
%   xlim([tau_opt(1)-273 tau_opt(60)-273])
   title('Max','FontSize',16)
       pos = get(gca, 'Position');
    pos(1) = 0.03;
    pos(2)= 0.675;
    pos(3) = 0.95;
    pos(4)=0.275;
    set(gca, 'Position', pos,'Fontsize',14,'XTickLabel',{' '})
 
   subplot(3,1,2)
   var_tmp=reshape(Big_R(:,2,:),size(Big_R,1),size(Big_R,3));
   Standard_deviation=mean(var_tmp,1);
boxplot(var_tmp,'BoxStyle','filled','Colors','k','whisker',1000)
 %  xlim([tau_opt(1)-273 tau_opt(60)-273])
   title('Sd','FontSize',16)
          pos = get(gca, 'Position');
    pos(1) = 0.03;
    pos(2)=0.365;
    pos(3) = 0.95;
    pos(4)=0.275;
    set(gca, 'Position', pos,'Fontsize',14,'XTickLabel',{' '})
     

   subplot(3,1,3)
   var_tmp=reshape(Big_R(:,3,:),size(Big_R,1),size(Big_R,3));
   Mean_value=mean(var_tmp,1);
boxplot(var_tmp,'BoxStyle','filled','Colors','k','whisker',1000)
  % xlim([tau_opt(1)-273 tau_opt(60)-273])
   title('Mean','FontSize',16)
          pos = get(gca, 'Position');
    pos(1) = 0.03;
    pos(2)=0.05;
    pos(3) = 0.95;
    pos(4)=0.275;
    set(gca, 'Position', pos,'Fontsize',14)
   
   T=table(Max,Standard_deviation,Mean_value)
   writetable(T,'./output_simulation/growth_rate_analysis.txt','Delimiter',';')
