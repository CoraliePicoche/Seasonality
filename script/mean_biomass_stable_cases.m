%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% This script draws Fig.3 in the article, biomass-trait distribution for
%%% the cases with none or both of the coexistence mechanisms (either only
%%% one species or 60 species at the end of the simulation)

clear all; close all; clc;

%Dynamics parameters
thresh_min=10^(-6); %threshold below which a species is considered extinct
yspan=200; %number of years taken into account when averaging biomasses

%Graphics parameters
afontsize=8;
col=jet(60);

dir_output='./output_simulation/white_noise/morta_variable';


%Load maximum and mean growth rates
T = readtable("output_simulation/growth_rate_analysis.txt","Delimiter",";");
max_growth_rate=table2array(T(:,1));
mean_growth_rate=table2array(T(:,3));
%Scale growth rates
max_growth_rate=max_growth_rate/max(max_growth_rate);
mean_growth_rate=mean_growth_rate/max(mean_growth_rate);

%Begin loading results
biomass_final_60=zeros(60,100,2);
%Filename for +SE+SSR
extension='_10higher.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_60(:,iter,1)=mean_value;
end;

dir_output='./output_simulation/season/morta_variable/';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_60(:,iter,2)=mean_value;
end;


dir_output='./output_simulation/white_noise/morta_variable';
%Filename for -SE-SSR
extension='_noforcedcompetition_weightedinteraction.mat';
white_noise_comm=zeros(1,100);
biomass_final_1=zeros(60,100,2);
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    nb_species=nb_species(end);
    mean_value=species_mean_value(youtbis, yspan);
    white_noise_comm(iter)=find(youtbis(end,:)>thresh_min);
    biomass_final_1(white_noise_comm(iter),iter,1)=mean_value(white_noise_comm(iter));
end;

dir_output='./output_simulation/season/morta_variable';
extension='_noforcedcompetition_weightedinteraction.mat';
season_comm=zeros(1,100);
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    nb_species=nb_species(end);
    mean_value=species_mean_value(youtbis, yspan);
    season_comm(iter)=find(youtbis(end,:)>thresh_min);
    biomass_final_1(season_comm(iter),iter,2)=mean_value(season_comm(iter));
end;

%Plot
fig=figure;
set(fig,'defaultAxesColorOrder',[[0 0 0]; [0 0 0]]);

subplot(2,2,1)

hold on

%Plot growth rates
yyaxis right;
plot(tau_opt-273,max_growth_rate,'o','MarkerEdgeColor','k','MarkerSize',3)
plot(tau_opt-273,mean_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',3)
set(gca,'YTickLabel',[]);

%Plot mean biomass for -SE-SSR and a random noise
yyaxis left
for s1=1:60
 plot(tau_opt(s1)-273,biomass_final_1(s1,:,1),'o','MarkerFaceColor',col(s1,:),'MarkerEdgeColor','k')
end

tau_tmp=zeros(1,length(tau_opt));
for s1=1:60
    tau_tmp(s1)=sum(biomass_final_1(s1,:,1)>0);
end;
xlim([min(tau_opt)-273 max(tau_opt)-273+0.1])
ylim([750 850])
ylabel({"Random noise";'Biomass'})
 hold off;
box off
text(15.15,845,'a','Fontsize',afontsize)
pos = get(gca, 'Position')
pos(1)=0.13;
pos(2)=0.5838;
pos(3)=0.3347;
pos(4)=0.3412;
tt1=title('1 species (-storage-SSR)','Fontsize',afontsize,'FontWeight','Normal');
titlePos = get( tt1 , 'position');
titlePos(2)=858.6;
set(tt1,'position',titlePos);
set(gca,'Position',pos,'Fontsize',afontsize,'xtick',[])%,'ytick',[])

%Plot mean biomass for -SE-SSR and a seasonal noise
subplot(2,2,3)
hold on
yyaxis right;
plot(tau_opt-273,max_growth_rate,'o','MarkerEdgeColor','k','MarkerSize',3)
plot(tau_opt-273,mean_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',3)
set(gca,'YTickLabel',[]);

yyaxis left
for s1=1:60
 plot(tau_opt(s1)-273,biomass_final_1(s1,:,2),'o','MarkerFaceColor',col(s1,:),'MarkerEdgeColor','k')
end
xlim([min(tau_opt)-273 max(tau_opt)-273+0.1])
ylim([750 850])
ylabel({'Seasonal noise';'Biomass'})
xlabel('Thermal optimum')
box off
text(15.15,845,'c','Fontsize',afontsize)
hold off;
xtick(tau_opt(1:9:length(tau_opt))-273)
xaxlabel=sprintfc("%.1f",tau_opt(1:9:length(tau_opt))-273);
set(gca,'XTickLabel',xaxlabel)%,'ytick',[])
pos = get(gca, 'Position')
pos(1)=0.13;
pos(2)=0.11;
pos(3)=0.3347;
pos(4)=0.3412;
set(gca,'Position',pos,'Fontsize',afontsize)
box off;

%Plot mean biomass for +SE+SSR and a random noise
subplot(2,2,2)
yyaxis right;
hold on;
plot(1:60,max_growth_rate,'o','MarkerEdgeColor','k','MarkerSize',3)
plot(1:60,mean_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',3)
ylabel('Growth rate','Fontsize',afontsize)

yyaxis left
boxplot(biomass_final_60(:,:,1)','BoxStyle','filled','Colors',col,'whisker',1000)
xlim([1 60.1])
maxi=get(gca,'Ylim');
maxi=maxi(2);
text(2,0.95*maxi,'b','Fontsize',afontsize)
box off;
pos = get(gca, 'Position')
pos(1)=0.5703;
pos(2)=0.5838;
pos(3)=0.3347;
pos(4)=0.3412;
tt2=title('60 species (+storage+SSR)','Fontsize',afontsize,'FontWeight','Normal');
titlePos = get( tt2 , 'position');
titlePos(2)=16.9;
set(tt2,'position',titlePos);
hold off;
set(gca,'Position',pos,'Fontsize',afontsize,'xtick',[])

%Plot mean biomass for +SE+SSR and a seasonal noise
subplot(2,2,4)
yyaxis right;
hold on;
plot(1:60,max_growth_rate,'o','MarkerEdgeColor','k','MarkerSize',3)
plot(1:60,mean_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',3)
ylabel('Growth rate','Fontsize',afontsize)
yyaxis left
boxplot(biomass_final_60(:,:,2)','BoxStyle','filled','Colors',col,'whisker',1000) 
xlim([1 60.1])
    
maxi=get(gca,'Ylim');
maxi=maxi(2);
text(2,12.75,'d','Fontsize',afontsize)
hold off;       
xtick(1:9:60)
xticklabels(tau_opt(1:9:length(tau_opt))-273)
set(gca,'XTickLabel',xaxlabel)
pos = get(gca, 'Position')
pos(1)=0.57304;
pos(2)=0.11;
pos(3)=0.3347;
pos(4)=0.3412;
xlabel('Thermal optimum')
set(gca,'Position',pos,'Fontsize',afontsize)
box off;

%Save fig
set(gcf,'Position',[680 558 520 420])
fig.Renderer='Painters';
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./article/graphe/Fig3_morta_variable','-depsc')
