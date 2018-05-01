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
afontsize=12;
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
max=get(gca,'Ylim');
max=max(2);
text(15,0.95*max,'a','Fontsize',afontsize)
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
max=get(gca,'Ylim');
max=max(2);
text(15,0.95*max,'c','Fontsize',afontsize)
xticks(seq*365);
xticklabels(round(seq,2)-round(seq(1),2));
xlim([seq(1)*365 seq(end)*365])
yl(2)=ylabel('Biomass (kg/area)')
set(gca,'Fontsize',afontsize)
xlabel('Time (year)')
hold off;
box off;


%b) Theta=1.3 just to show the season
load("output_simulation/season/iter2_codeversion_20180228_theta1p3.mat")
yend=size(tau,2);
use_temperature=tau((yend-ylast):yend);
yend=size(youtbis,1);
use_community=youtbis((yend-ylast):yend,:);

h(2)=subplot(2,2,2)
plot(use_temperature-273.15,'-k','LineWidth',.5)
max=get(gca,'Ylim');
max=max(2);
text(15,0.95*max,'b','Fontsize',afontsize)
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
max=get(gca,'Ylim');
max=max(2);
text(15,0.95*max,'d','Fontsize',afontsize)
xticks(seq*365);
xticklabels(round(seq,2)-round(seq(1),2));
xlim([seq(1)*365 seq(end)*365])
xlabel('Time (year)')
set(gca,'Fontsize',afontsize)
hold off;
box off;

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
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./Rapport/graphe/essai','-dpdf')
