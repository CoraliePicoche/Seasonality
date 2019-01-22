%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% This script draws Fig.4 in the article, biomass-trait distribution for
%%% the cases with only one coexistence mechanism (storage effect only or
%%% strong-self regulation only)


clear all; close all; clc;

%Dynamics parameters
thresh_min=10^(-6); %threshold below which a species is considered extinct
yspan=200; %number of years taken into account when averaging biomasses

%Graphics parameters
afontsize=10;
col=jet(60);
subplot_id=zeros(1,2); %keep the id of the labels to keep them aligned

%Load maximum and mean growth rates
T = readtable("output_simulation/growth_rate_analysis.txt","Delimiter",";");
max_growth_rate=table2array(T(:,1));
mean_growth_rate=table2array(T(:,3));
%Scale growth rates
max_growth_rate=max_growth_rate/max(max_growth_rate);
mean_growth_rate=mean_growth_rate/max(mean_growth_rate);

%Begin loading results
biomass_final_1=zeros(60,100,2);
dir_output='./output_simulation/white_noise/';
%Filename for +SE-SSR
extension='.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_1(:,iter,1)=mean_value;
end;

dir_output='./output_simulation/season/';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_1(:,iter,2)=mean_value;
end;

%Compute the percentiles to plot the biomass-trait distributions
tmp=zeros(length(tau_opt),5,2);
for t=1:length(tau_opt)
    tmp(t,1,1)=min(biomass_final_1(t,:,1));
    tmp(t,2,1)=max(biomass_final_1(t,:,1));
    tmp(t,3,1)=prctile(biomass_final_1(t,:,1),50);
    tmp(t,4,1)=prctile(biomass_final_1(t,:,1),90);
    tmp(t,5,1)=mean(biomass_final_1(t,:,1));
    tmp(t,1,2)=min(biomass_final_1(t,:,2));
    tmp(t,2,2)=max(biomass_final_1(t,:,2));
    tmp(t,3,2)=prctile(biomass_final_1(t,:,2),50);
    tmp(t,4,2)=prctile(biomass_final_1(t,:,2),90); 
    tmp(t,5,2)=mean(biomass_final_1(t,:,2));
end

%Draw shaded areas
plou1=[tau_opt fliplr(tau_opt)]-273;
min_median_wn=[tmp(:,1,1)' fliplr(tmp(:,3,1)')];
median_90_wn=[tmp(:,3,1)' fliplr(tmp(:,4,1)')];
nin_max_wn=[tmp(:,4,1)' fliplr(tmp(:,2,1)')];
min_median_season=[tmp(:,1,2)' fliplr(tmp(:,3,2)')];
median_90_season=[tmp(:,3,2)' fliplr(tmp(:,4,2)')];
nin_max_season=[tmp(:,4,2)' fliplr(tmp(:,2,2)')];
fig=figure;
set(fig,'defaultAxesColorOrder',[[0 0 0]; [0 0 0]]);
subplot(2,1,1)
hold on
yyaxis left;
fill(plou1,min_median_wn,'b','EdgeColor','none','FaceAlpha',.3)
fill(plou1,median_90_wn,'b','EdgeColor','none','FaceAlpha',.5)
fill(plou1,nin_max_wn,'b','EdgeColor','none','FaceAlpha',.7)
fill(plou1,min_median_season,'r','EdgeColor','none','FaceAlpha',.3) 
fill(plou1,median_90_season,'r','EdgeColor','none','FaceAlpha',.5)
fill(plou1,nin_max_season,'r','EdgeColor','none','FaceAlpha',.7)

%Plot an example of one simulation's dynamics over the shaded area
iter=7;
plot(tau_opt-273,biomass_final_1(:,iter,1),'-o','MarkerFaceColor','b','LineWidth',2,'color','b')
plot(tau_opt-273,biomass_final_1(:,iter,2),'-o','MarkerFaceColor','r','LineWidth',2,'color','r')

xticks(tau_opt(1:9:length(tau_opt))-273)     
xaxlabel=cell(1,length(tau_opt));
set(gca,'XTickLabel',xaxlabel)
xtickangle(90)
subplot_id(1)=ylabel({"Storage effect";'Biomass'});
set(gca,'Fontsize',afontsize)

%Add growth rate max and mean
yyaxis right;
plot(tau_opt-273,max_growth_rate,'o','MarkerEdgeColor','k','MarkerSize',3)
plot(tau_opt-273,mean_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',3)
id=find(mean_growth_rate==1);
ylabel('Growth rate','Fontsize',afontsize);
ylim([0 1.1])

text(15.1,1.*0.95,'a','Fontsize',afontsize)
plot([tau_opt(id) tau_opt(id)]-273,[0 mean_growth_rate(id)],'--k','LineWidth',2)
hold off;
pos=get(gca,'Position')
set(gca,'Position',pos)

%Files for -SE+SSR
subplot(2,1,2)
extension='_noforcedcompetition_10higherintra_weightedinteraction.mat';
biomass_final_2=zeros(60,100,2);

dir_output='./output_simulation/white_noise/';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_2(:,iter,1)=mean_value;
end;

dir_output='./output_simulation/season/';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_2(:,iter,2)=mean_value;
end;

%Compute percentiles
tmp=zeros(length(tau_opt),4,2);
for t=1:length(tau_opt)
    tmp(t,1,1)=min(biomass_final_2(t,:,1));
    tmp(t,2,1)=max(biomass_final_2(t,:,1));
    tmp(t,3,1)=prctile(biomass_final_2(t,:,1),50);
    tmp(t,4,1)=prctile(biomass_final_2(t,:,1),90);
    tmp(t,5,1)=mean(biomass_final_2(t,:,1));
    tmp(t,1,2)=min(biomass_final_2(t,:,2));
    tmp(t,2,2)=max(biomass_final_2(t,:,2));
    tmp(t,3,2)=prctile(biomass_final_2(t,:,2),50);
    tmp(t,4,2)=prctile(biomass_final_2(t,:,2),90);
    tmp(t,5,2)=mean(biomass_final_2(t,:,2));
end
hold on

%Draw shaded areas
plou1=[tau_opt fliplr(tau_opt)]-273;
min_median_wn=[tmp(:,1,1)' fliplr(tmp(:,3,1)')];
median_90_wn=[tmp(:,3,1)' fliplr(tmp(:,4,1)')];
nin_max_wn=[tmp(:,4,1)' fliplr(tmp(:,2,1)')];
min_median_season=[tmp(:,1,2)' fliplr(tmp(:,3,2)')];
median_90_season=[tmp(:,3,2)' fliplr(tmp(:,4,2)')];
nin_max_season=[tmp(:,4,2)' fliplr(tmp(:,2,2)')];
fill(plou1,min_median_wn,'b','EdgeColor','none','FaceAlpha',.3)
fill(plou1,median_90_wn,'b','EdgeColor','none','FaceAlpha',.5)
fill(plou1,nin_max_wn,'b','EdgeColor','none','FaceAlpha',.7)
fill(plou1,min_median_season,'r','EdgeColor','none','FaceAlpha',.3)
fill(plou1,median_90_season,'r','EdgeColor','none','FaceAlpha',.5)
fill(plou1,nin_max_season,'r','EdgeColor','none','FaceAlpha',.7)

%Example of one simualtion's dynamics
iter=7;
plot(tau_opt-273,biomass_final_2(:,iter,1),'-o','MarkerFaceColor','b','LineWidth',2,'color','b')
plot(tau_opt-273,biomass_final_2(:,iter,2),'-o','MarkerFaceColor','r','LineWidth',2,'color','r')

xticks(tau_opt(1:9:length(tau_opt))-273);
xaxlabel=sprintfc("%.1f",tau_opt(1:9:length(tau_opt))-273);
xlabel('Thermal optimum','Fontsize',afontsize)
set(gca,'XTickLabel',xaxlabel)
subplot_id(2)=ylabel({"Strong Self-Regulation";'Biomass'},'Fontsize',afontsize);
set(gca,'Fontsize',afontsize)

%Add growth rates max and mean
yyaxis right;
plot(tau_opt-273,max_growth_rate,'o','MarkerEdgeColor','k','MarkerSize',3)
plot(tau_opt-273,mean_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',3)
ylabel('Growth rate','Fontsize',afontsize);
ylim([0 1.1])
text(15.1,1*0.95,'b','Fontsize',afontsize)

%Identigy the species with the best long-terme average growth rate
id=find(mean_growth_rate==1);
plot([tau_opt(id) tau_opt(id)]-273,[0 mean_growth_rate(id)],'--k','LineWidth',2)

pos=get(gca,'Position');
pos(4)=0.35;
pos(2)=0.19;
set(gca,'Position',pos)
positions = cell2mat(get(subplot_id([1 2]), 'Position'));
xpos = min(positions(:,1))-0.025;
for i=[1 2]
    set(subplot_id(i), 'Position',[xpos, positions(i,2), positions(i,3)]);
end
hold off;
pos=get(gca,'Position');
pos(2)=0.11;
set(gca,'Position',pos)

set(fig,'Position',[680 558 520 420])
fig.Renderer='Painters';
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./article/graphe/Fig4_with_mean','-depsc')

