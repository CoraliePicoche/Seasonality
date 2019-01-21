%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Figure X in our article : just a proposition to represent the constant
%%% case : +SE+SND and -SE-SND

clear all; close all; clc;
%First definitions
%Will look at the last two years
thresh_min=10^(-6);
col=jet(60);
S=60;

%Graphics
afontsize=12;

%All species
subplot(1,2,1)
load("output_simulation/SV_same_temp/iter2_codeversion_20180228_theta0_competitonintrahigherthanextra.mat")
mean_value=species_mean_value(youtbis, 500); hold on;
for s1=1:S
    bar(tau_opt(s1)-273.15,mean_value(s1),0.1,'FaceColor',col(s1,:));
end;
ylabel('Biomass (kg/area)')
xlabel('Thermal optimum (°C)')
xlim([14.5 25.5])
max=get(gca,'Ylim');
max=max(2);
text(tau_opt(1)-273.15,max*0.95,'a','Fontsize',afontsize)
set(gca,'Fontsize',afontsize)
hold off;

subplot(1,2,2)
load("output_simulation/no_forced_competition/iter2_codeversion_20180228_theta0_noforcedcompetition_weightedinteraction.mat")
mean_value=species_mean_value(youtbis, 500); hold on;
for s1=1:S
    bar(tau_opt(s1)-273.15,mean_value(s1),0.1,'FaceColor',col(s1,:));
end;
max=get(gca,'Ylim');
xlabel('Thermal optimum (°C)')
max=max(2);
text(tau_opt(1)-273.15,max*0.95,'b','Fontsize',afontsize)
xlim([14.5 25.5])
set(gca,'Fontsize',afontsize)
hold off;

fig = gcf;
fig_pos=get(fig,'Position')
set(gcf,'Position',[fig_pos(1) fig_pos(2) fig_pos(3)*1.5 fig_pos(4)])
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./Rapport/graphe/figureX','-dpdf')