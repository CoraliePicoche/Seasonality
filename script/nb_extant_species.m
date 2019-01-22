%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% This script draws Fig.2 in the article, boxplots for the number of
%%% extant species at the end of all types of simulations (with and without
%%% storage effect, SE ; with and without strong self-regulation, SSR)

clear all; close all; clc;

thresh_min=10^(-6); %threshold below which a species is considered extinct
max_iter=100;

dir_output='./output_simulation/white_noise/morta_variable';
extant_species_wn=zeros(max_iter,4); %results for a random noise

%Filename for -SE-SSR
extension='_noforcedcompetition_weightedinteraction.mat';
for iter=1:max_iter
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_wn(iter,1)=nb_species(end);
end;


%Filename for +SE-SSR
extension='.mat';
for iter=1:max_iter
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_wn(iter,2)=nb_species(end);
end;

%Filename for -SE+SSR
extension='_noforcedcompetition_10higherintra_weightedinteraction.mat';
for iter=1:max_iter
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_wn(iter,3)=nb_species(end); 
end;

%Filename for +SE+SSR
extension='_10higher.mat';
for iter=1:max_iter
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_wn(iter,4)=nb_species(end); 
end;

dir_output='./output_simulation/season/morta_variable';
extant_species_season=zeros(max_iter,4); %stores results for seasonal noise

%Filename for -SE-SSR
extension='_noforcedcompetition_weightedinteraction.mat';
for iter=1:max_iter
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_season(iter,1)=nb_species(end);

end;

%Filename for +SE-SSR
extension='.mat';
for iter=1:max_iter
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_season(iter,2)=nb_species(end);

end;

%Filename for -SE+SSR
extension='_noforcedcompetition_10higherintra_weightedinteraction.mat';
for iter=1:max_iter
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_season(iter,3)=nb_species(end);

end;

%Filename for +SE+SSR
extension='_10higher.mat';
for iter=1:max_iter
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    extant_species_season(iter,4)=nb_species(end); 

end;

tmp=[extant_species_wn(:,1) extant_species_season(:,1) extant_species_wn(:,2) extant_species_season(:,2) extant_species_wn(:,3) extant_species_season(:,3) extant_species_wn(:,4) extant_species_season(:,4)];

%Plot
afontsize=10;
boxplot(tmp,'positions',[1.2 1.3 1.6 1.7 2.0 2.1 2.4 2.5],'colors','k','whisker',10^500,'labels',{'','','','','','','',''},'Symbol','+k')
xtick([1.25 1.65 2.05 2.45])
xticklabels({'-storage-SSR','+storage-SSR','-storage+SSR','+storage+SSR'})
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
%Save
fig = gcf;
set(fig,'Position',[680 558 520 420])
fig.Renderer='Painters';
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./article/graphe/Fig2_mortavariable','-depsc')
