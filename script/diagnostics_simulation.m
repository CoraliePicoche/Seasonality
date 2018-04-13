%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Function which gives diagnostics on a given simulation
%%% Number of extant species at the end of the simulation
%%% Mean biomass of the whole community for the last year
%%% Convergence (seen as the stability as the number of species, and having
%%% a look at the CV of total biomass) : WARNING! This is especially
%%% important to choose a yspan corresponding to the number of years we
%%% consider in the following analyses
%%% Dynamics for the last 2 years
%%% Mean biomass for the last yspan years
%%% Rank-abundance curve
%%% Species-specific and community-wide synchronies

clear all; close all; clc;

global tau0 a_r_tau0 E_r k


ywindow=5;
thresh_min=10^(-6);
alpha_compet=0.001;

tau0=293;
a_r_tau0 = 386/365; %normalization constant for growth rate at reference temperature SV (kg/(kg*year))
E_r=0.467; %eV, activation energy
k=8.6173324*10^(-5); %Boltzmann's constant in eV.K-1
fun=@(x,b,tau_opt) growth_response(x).*frac_max(x,tau_opt,b);


X=1;
type='Ashby_formulation';
nice_type='Ashby';
addenda=''; %Here, we can add if we're using no_forced_competition, or theta
filename=strcat('./output_simulation/SV_same_temp/iter',num2str(X),'_codeversion_20180228_theta0_',type)

load(filename)
S=size(youtbis,2);
switch nice_type
    case 'Ashby'
        for i=1:S
            for j=1:S
                A(i,j)= alpha_compet*10*integral(@(x)fun(x,b(i),tau_opt(i)).*fun(x,b(j),tau_opt(j)),10+273,30+273)/integral(@(x)(fun(x,b(i),tau_opt(i))).^2,10+273,30+273);
            end;
        
        end
    case 'Regular'
        A=ones(S)*alpha_compet;
    case 'Intra group 10x higher'
        A=ones(S)*alpha_compet+diag(ones(S,1)*alpha_compet*9);
    case 'Intra group 4x higher'
        A=ones(S)*alpha_compet+diag(ones(S,1)*alpha_compet*3);
    case 'Weighted interaction'
        A=ones(S)*alpha_compet;
        r=zeros(S,length(tau));
        for i=1:S
            r(i,:)=fun(tau,b(i),tau_opt(i));   
        end;
        tmp_r=mean(r,2);
        A=tmp_r.*A;
end;
'Max eigen A'
max(abs(eig(A)))

%Initialize colors that will be used later
c=jet(S);

%Convergence
convergence_function(youtbis);
%Here's a good example: with the simulation I'm looking at (iter1, Ashby), the number of
%species decreases during the last 200 years, so I need to change yspan
%from its default value, 200 years
yspan=150;

%Dynamics
%By default, we output the last 2 years
ymin=size(youtbis,1)-2*365+1;
ymax=size(youtbis,1);
figure; hold on;
for s1=1:S
    plot(ymin:ymax,youtbis(ymin:ymax,s1),'LineWidth',2,'color',c(s1,:));
end;
seq=ymin/365:0.25:ymax/365;
xticks(seq*365);
xticklabels(round(seq,2)-round(seq(1),2));
xlim([seq(1)*365 seq(end)*365])
ylabel('Abundance')
set(gca,'Fontsize',16)
title({'Dynamics last 2 years',strcat(num2str(X),nice_type,addenda)},'Fontsize',18)
hold off;

%Mean-value
mean_value=species_mean_value(youtbis, yspan);
figure; hold on;
for s1=1:S
    bar(tau_opt(s1)-273,mean_value(s1),0.1,'FaceColor',c(s1,:));
end;
ylabel('Abundance')
set(gca,'yscale','log','Fontsize',16)
title({'Mean biomass',strcat(num2str(X),nice_type,addenda)},'Fontsize',18)
hold off;

%RAC
comm_SV=mean(youtbis((end-365*yspan):end,:),1);
myplot_RAC(comm_SV,{''},{strcat(num2str(X),nice_type,addenda)},{},c)
set(gca,'Fontsize',16)

%Species-specific synchronys
spp_synchrony=species_specific_synchrony(youtbis,yspan,ywindow,A); %Here, I'll need to add the community matrix
figure; hold on;
for s1=1:S
    plot(1:size(spp_synchrony,1),spp_synchrony(:,s1),'color',c(s1,:));
end
line(get(gca,'XLim'),[0 0],'Color','k','LineWidth',1.5)
title({'Species-specific synchrony',strcat(num2str(X),nice_type,addenda)},'Fontsize',18)
set(gca,'Fontsize',16)
hold off;

%Community-wide synchrony
tab_indices=community_wide_indices(filename);
tab_indices=tab_indices(:,(end-yspan+1):end);
figure;
subplot(2,1,1);
plot(1:size(tab_indices,2),tab_indices(1,:),'LineWidth',2)
title({'Loreau index',strcat(num2str(X),nice_type,addenda)},'Fontsize',18)
pos = get(gca, 'Position');
pos(1)=0.03;
pos(2)=0.525;
pos(3)=0.95;
pos(4)=0.4;
set(gca,'Position',pos,'Fontsize',16)

subplot(2,1,2);
plot(1:size(tab_indices,2),tab_indices(2,:),'LineWidth',2)
title({'Gross index',strcat(num2str(X),nice_type,addenda)},'Fontsize',18)
pos = get(gca, 'Position');
pos(1)=0.03;
pos(2)=0.05;
pos(3)=0.95;
pos(4)=0.4;
set(gca,'Position',pos,'Fontsize',16)




