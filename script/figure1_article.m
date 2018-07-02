%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Figure 1 in our article : temperature and time series

clear all; close all; clc;
%First definitions
%Will look at the last two years
ylast=2*365;
thresh_min=10^(-6);
col=jet(60);
S=60;

%Graphics
afontsize=8;
alinewidth=2.;

%a) Theta=0
load("output_simulation/white_noise/iter2_codeversion_20180228_theta0.mat")
yend=size(tau,2);
use_temperature=tau((yend-ylast):yend);
yend=size(youtbis,1);
use_community=youtbis((yend-ylast):yend,:);

h=zeros(1,4)
yl=zeros(1,2)

h(1)=subplot(2,2,1)
plot(use_temperature-273.15,'-k','LineWidth',.5)
maxi=get(gca,'Ylim');
maxi=maxi(2);
text(15,0.95*maxi,'a','Fontsize',afontsize)
seq=0/365:0.5:ylast/365;
xticks(seq*365);
xticklabels(round(seq,2)-round(seq(1),2));
xlim([seq(1)*365 seq(end)*365])
yl(1)=ylabel('Temperature (°C)')
set(gca,'Fontsize',afontsize)
box off;

%c) Time series for theta=0
h(3)=subplot(2,2,3)
hold on;
for s1=1:S
    if youtbis(end,s1)>thresh_min 
       plot(use_community(:,s1),'LineWidth',alinewidth,'color',col(s1,:));
    end    
end;
maxi=get(gca,'Ylim');
maxi=maxi(2);
text(15,0.95*maxi,'c','Fontsize',afontsize)
xticks(seq*365);
xticklabels(round(seq,2)-round(seq(1),2));
xlim([seq(1)*365 seq(end)*365])
yl(2)=ylabel('Biomass (kg/area)')
set(gca,'Fontsize',afontsize)
xlabel('Time (year)')
hold off;
box off;

youtbis_wn=youtbis;

%b) Theta=1.3 just to show the season
load("output_simulation/season/iter2_codeversion_20180228_theta1p3.mat")
yend=size(tau,2);
use_temperature=tau((yend-ylast):yend);
yend=size(youtbis,1);
use_community=youtbis((yend-ylast):yend,:);

h(2)=subplot(2,2,2)
plot(use_temperature-273.15,'-k','LineWidth',.5)
maxi=get(gca,'Ylim');
maxi=maxi(2)
text(15,0.95*35,'b','Fontsize',afontsize)
xticks(seq*365);
xticklabels(round(seq,2)-round(seq(1),2));
xlim([seq(1)*365 seq(end)*365])
set(gca,'Fontsize',afontsize)
box off;

%d) Time series for theta=1.3
h(4)=subplot(2,2,4)
hold on;
for s1=1:S
    if youtbis(end,s1)>thresh_min 
       plot(use_community(:,s1),'LineWidth',alinewidth,'color',col(s1,:));
    end    
end;
maxi=get(gca,'Ylim');
maxi=maxi(2);
text(15,0.95*maxi,'d','Fontsize',afontsize)
xticks(seq*365);
xticklabels(round(seq,2)-round(seq(1),2));
xlim([seq(1)*365 seq(end)*365])
xlabel('Time (year)')
set(gca,'Fontsize',afontsize);
hold off;
box off;

youtbis_season=youtbis;

%Adjust everything
positions = cell2mat(get(h([1 3]), 'Position'));
x = min(positions(:,1));
for i=[1 3]
    pos = get(h(i), 'Position');
    set(h(i), 'Position',[x, pos(2), pos(3) + (pos(1) - x), pos(4)]);
end
positions = cell2mat(get(yl([1 2]), 'Position'));
xpos = min(positions(:,1));
for i=[1 2]
    set(yl(i), 'Position',[xpos, positions(i,2), positions(i,3)]);
end

fig = gcf;
set(fig,'Position',[680 558 520 420])
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
get(fig,'Position')
get(gca,'FontSize')
print(fig,'./article/graphe/Fig1','-depsc')


% Appendices
yspan=200;
    mean_value=species_mean_value(youtbis_wn, yspan);
    figure;subplot(1,2,1); hold on;
for s1=1:S
    bar(tau_opt(s1)-273,mean_value(s1),0.1,'FaceColor',col(s1,:));
end;
pos=get(gca,'Position')
pos(1)=0.07;pos(2)=0.15;
pos(3)=0.43;
set(gca,'Position',pos)
ylabel('Biomass')
xlabel('Thermal optimum')
mini=min(mean_value(mean_value>0));
ylimit=[mini*0.95 max(mean_value)+0.05*mini]; 
set(gca,'yscale','log','Fontsize',16,'YLim',ylimit)
hold off;

    mean_value=species_mean_value(youtbis_season, yspan);
    subplot(1,2,2); hold on;
for s1=1:S
    bar(tau_opt(s1)-273,mean_value(s1),0.1,'FaceColor',col(s1,:));
end;
%ylabel('Biomass')
pos=get(gca,'Position')
pos(1)=0.56;pos(2)=0.15;
pos(3)=0.43;
set(gca,'Position',pos)
mini=min(mean_value(mean_value>0));
ylimit=[mini*0.95 max(mean_value)+0.05*mini]; 
set(gca,'yscale','log','Fontsize',16,'YLim',ylimit)
xlabel('Thermal optimum')
hold off;
fig = gcf;
set(fig,'Position',[680 558 1200 420])
get(gca,'FontSize')
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./article/graphe/FigS1','-depsc')