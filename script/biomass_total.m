%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Biomasses in each simulations + evenness

clear all; close all; clc;
thresh_min=10^(-6);
afontsize=14;
yspan=200;

dir_output='./output_simulation/white_noise/';
extant_species_wn=zeros(60,100,4);


%Filename for -SE-SND
extension='_noforcedcompetition_weightedinteraction.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
        mean_value=species_mean_value(youtbis, yspan);
    extant_species_wn(:,iter,1)=mean_value;
end;


%Filename for +SE-SND
extension='.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
        mean_value=species_mean_value(youtbis, yspan);
    extant_species_wn(:,iter,2)=mean_value;
end;

%Filename for -SE+SND
extension='_noforcedcompetition_10higherintra_weightedinteraction.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
        mean_value=species_mean_value(youtbis, yspan);
    extant_species_wn(:,iter,3)=mean_value;

end;

%Filename for +SE+SND
extension='_10higher.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
        mean_value=species_mean_value(youtbis, yspan);
    extant_species_wn(:,iter,4)=mean_value;

end;

dir_output='./output_simulation/season/';
extant_species_season=zeros(60,100,4);

%Filename for -SE-SND
extension='_noforcedcompetition_weightedinteraction.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
        mean_value=species_mean_value(youtbis, yspan);
    extant_species_season(:,iter,1)=mean_value;

end;

%Filename for +SE-SND
extension='.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
        mean_value=species_mean_value(youtbis, yspan);
    extant_species_season(:,iter,2)=mean_value;

end;

%Filename for -SE+SND
extension='_noforcedcompetition_10higherintra_weightedinteraction.mat';

for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
        mean_value=species_mean_value(youtbis, yspan);
    extant_species_season(:,iter,3)=mean_value;

end;

%Filename for +SE+SND
extension='_10higher.mat';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
        mean_value=species_mean_value(youtbis, yspan);
    extant_species_season(:,iter,4)=mean_value;
end;

tmp_season=cumsum(extant_species_season,1);
tmp_season=tmp_season(60,:,:);
proba_season=extant_species_season./tmp_season;
ev_season=-sum(proba_season.*log(proba_season+10^-7),1)./log(60);

tmp_wn=cumsum(extant_species_wn,1);
tmp_wn=tmp_wn(60,:,:);
proba_wn=extant_species_wn./tmp_wn;
ev_wn=-sum(proba_wn.*log(proba_wn+10^-7),1)./log(60);

tmp=[tmp_wn(1,:,1);tmp_season(1,:,1);tmp_wn(1,:,2);tmp_season(1,:,2);tmp_wn(1,:,3);tmp_season(1,:,3);tmp_wn(1,:,4);tmp_season(1,:,4)];
tmp_ev=[ev_wn(1,:,1);ev_season(1,:,1);ev_wn(1,:,2);ev_season(1,:,2);ev_wn(1,:,3);ev_season(1,:,3);ev_wn(1,:,4);ev_season(1,:,4)];
tmp=tmp';
tmp_ev=tmp_ev';
boxplot(tmp,'positions',[1.2 1.3 1.6 1.7 2.0 2.1 2.4 2.5],'colors','k','labels',{'','','','','','','',''},'Symbol','+k') %'whisker',10^500,
xtick([1.25 1.65 2.05 2.45])
xticklabels({'-storage-SND','+storage-SND','-storage+SND','+storage+SND'})
h = findobj(gca,'Tag','Box');
col=['r','b','r','b','r','b','r','b'];
ll=[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,1.0];
for j=1:length(h)
patch(get(h(j),'XData'),get(h(j),'YData'),col(j),'FaceAlpha',.5,'LineWidth',ll(j));
end
ylabel('Total biomass in the environment')
set(gca,'Fontsize',afontsize)

figure
boxplot(tmp_ev,'positions',[1.2 1.3 1.6 1.7 2.0 2.1 2.4 2.5],'colors','k','labels',{'','','','','','','',''},'Symbol','+k') %'whisker',10^500,
xtick([1.25 1.65 2.05 2.45])
xticklabels({'-storage-SND','+storage-SND','-storage+SND','+storage+SND'})
h = findobj(gca,'Tag','Box');
col=['r','b','r','b','r','b','r','b'];
ll=[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,1.0];
for j=1:length(h)
patch(get(h(j),'XData'),get(h(j),'YData'),col(j),'FaceAlpha',.5,'LineWidth',ll(j));
end
ylabel('Evenness')
set(gca,'Fontsize',afontsize)