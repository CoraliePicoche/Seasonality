%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Making sense of growth rates


clear all; close all; clc;
T = readtable("output_simulation/SV_same_temp/growth_rate_analysis.csv","Delimiter",";");

yspan=200;

extension='_noforcedcompetition_10higherintra_weightedinteraction.mat';

biomass_final_2=zeros(60,50,2);
dir_output='./output_simulation/white_noise/';
for iter=1:50
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_2(:,iter,1)=mean_value;
end;

dir_output='./output_simulation/season';
for iter=1:50
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_2(:,iter,2)=mean_value;
end;

max_growth_rate=table2array(T(:,1));
mean_growth_rate=table2array(T(:,3));

max_growth_rate=max_growth_rate/max(max_growth_rate);
mean_growth_rate=mean_growth_rate/max(mean_growth_rate);

%before plotting
figure
i=0;
for iter=[17 32]
    i=i+1;
    subplot(1,2,i)
    hold on;
    plot(tau_opt-273,biomass_final_2(:,iter,1),'-ob','MarkerFaceColor','b','LineWidth',2)
    plot(tau_opt-273,biomass_final_2(:,iter,2),'-or','MarkerFaceColor','r','LineWidth',2)
    title(num2str(iter),'Fontsize',16)
    set(gca,'Fontsize',14)
    hold off
end;
    
save_weird_stuff=biomass_final_2(:,[17 32],:);
biomass_final_2(:,[17 32],:)=nan; %I can plot them in the appendices, but here, they're just even more confusing
%close all;
fig=figure
set(fig,'defaultAxesColorOrder',[[0 0 0]; [0 0 0]]);
hold on;
yyaxis right
% iter=7
% plot(tau_opt-273,biomass_final_2(:,iter,1),'-ob');
% plot(tau_opt-273,biomass_final_2(:,iter,2),'-or');

tmp=zeros(length(tau_opt),4,2);
for t=1:length(tau_opt)
    tmp(t,1,1)=min(biomass_final_2(t,:,1));
    tmp(t,2,1)=max(biomass_final_2(t,:,1));
    tmp(t,3,1)=prctile(biomass_final_2(t,:,1),50);
    tmp(t,4,1)=prctile(biomass_final_2(t,:,1),90);
    tmp(t,1,2)=min(biomass_final_2(t,:,2));
    tmp(t,2,2)=max(biomass_final_2(t,:,2));
    tmp(t,3,2)=prctile(biomass_final_2(t,:,2),50);
    tmp(t,4,2)=prctile(biomass_final_2(t,:,2),90);    
end
hold on

%Feeling fancy
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
% 

    set(gca,'Fontsize',14)

% %simple version would be
% plou3=[tmp(:,1,1)' fliplr(tmp(:,2,1)')];
% fill(plou1,plou3,'b','EdgeColor','none','FaceAlpha',.3)
% plou3=[tmp(:,1,2)' fliplr(tmp(:,2,2)')];
% fill(plou1,plou3,'r','EdgeColor','none','FaceAlpha',.3)

yyaxis left
plot(tau_opt-273,max_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k')
plot(tau_opt-273,mean_growth_rate,'s','MarkerFaceColor','k','MarkerEdgeColor','k')
id=find(mean_growth_rate==1);fig=gcf
plot([tau_opt(id) tau_opt(id)]-273,[0 mean_growth_rate(id)],'--k','LineWidth',2)


fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./Rapport/graphe/extant_species','-dpdf')
