%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Boxplots for extant species in cases where the final result is variable

clear all; close all; clc;
thresh_min=10^(-6);
afontsize=8;

max_temp=20+273.15;
min_temp=20+273.15;

dir_output='./output_simulation/white_noise/';
extant_species_wn=zeros(100,4);


%Filename for -SE-SND
extension='_noforcedcompetition_weightedinteraction.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_wn(iter,1)=nb_species(end);
            if max(tau)>max_temp
        max_temp=max(tau);
    end
    if min(tau)<min_temp
        min_temp=min(tau);
    end;
end;


%Filename for +SE-SND
extension='.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_wn(iter,2)=nb_species(end);
end;

%Filename for -SE+SND
extension='_noforcedcompetition_10higherintra_weightedinteraction.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_wn(iter,3)=nb_species(end); 
end;

%Filename for +SE+SND
extension='_10higher.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_wn(iter,4)=nb_species(end); 
end;

dir_output='./output_simulation/season/';
extant_species_season=zeros(100,4);

%Filename for -SE-SND
extension='_noforcedcompetition_weightedinteraction.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_season(iter,1)=nb_species(end);

end;

%Filename for +SE-SND
extension='.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_season(iter,2)=nb_species(end);

end;

%Filename for -SE+SND
extension='_noforcedcompetition_10higherintra_weightedinteraction.mat';

for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_season(iter,3)=nb_species(end);

end;

%Filename for +SE+SND
extension='_10higher.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_season(iter,4)=nb_species(end); 

end;

tmp=[extant_species_wn(:,1) extant_species_season(:,1) extant_species_wn(:,2) extant_species_season(:,2) extant_species_wn(:,3) extant_species_season(:,3) extant_species_wn(:,4) extant_species_season(:,4)];
% boxplot(tmp,'positions',[1.2 1.3 1.5 1.6 1.8 1.9 2.1 2.2],'colors','k','whisker',10000,'labels',{'','','','','','','',''})
% xtick([1.25 1.55 1.85 2.15])
% xticklabels({'-SE-SND','+SE-SND','-SE+SND','+SE+SND'})
% h = findobj(gca,'Tag','Box');
% col=['r','b','r','b','r','b','r','b'];
% ll=[2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 2.0,2.0];
% for j=1:length(h)
% patch(get(h(j),'XData'),get(h(j),'YData'),col(j),'FaceAlpha',.5,'LineWidth',ll(j));
% end
% ylabel('Number of extant species')
% set(gca,'Fontsize',afontsize)

afontsize=10;
boxplot(tmp,'positions',[1.2 1.3 1.6 1.7 2.0 2.1 2.4 2.5],'colors','k','whisker',10^500,'labels',{'','','','','','','',''},'Symbol','+k')
xtick([1.25 1.65 2.05 2.45])
xticklabels({'-storage-SND','+storage-SND','-storage+SND','+storage+SND'})
a=get(gca,'xticklabel');
set(gca,'XTickLabel',a,'FontSize',afontsize);
h = findobj(gca,'Tag','Box');
col=['r','b','r','b','r','b','r','b'];
ll=[2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 2.0,2.0];
for j=1:length(h)
patch(get(h(j),'XData'),get(h(j),'YData'),col(j),'FaceAlpha',.5,'LineWidth',ll(j));
end
yl=ylabel('Number of extant species')
pos=get(yl,'Position')
set(yl, 'Position',[pos(1)-0.06, pos(2), pos(3)],'Fontsize',afontsize);
set(gca,'Fontsize',afontsize)
pos=get(gca,'Position')
pos(1)=0.12;
pos(3)=0.8;
set(gca,'Position',pos)
%box off;

fig = gcf;
set(fig,'Position',[680 558 520 420])
fig.Renderer='Painters';
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./article/graphe/Fig2','-depsc')
