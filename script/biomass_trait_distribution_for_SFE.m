% Biomass-trait distribution for the four cases we have, and two types of
% environment

clear all; close all; clc;
thresh_min=10^(-6);
yspan=200;
afontsize=12;


%%%%%%%%%%%%%%%%%%STABLE CASES%%%%%%%%%%%%%%%%
dir_output='./output_simulation/white_noise/';
%Filename for +SE+SND
extension='_10higher.mat';

biomass_final_60=zeros(60,100,2);

for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_60(:,iter,1)=mean_value;
end;

dir_output='./output_simulation/season';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_60(:,iter,2)=mean_value;
end;

dir_output='./output_simulation/white_noise/';
%Filename for -SE-SND
extension='_noforcedcompetition_weightedinteraction.mat';
white_noise_comm=zeros(1,100);
biomass_final_1=zeros(60,100,2);
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    nb_species=nb_species(end);
        mean_value=species_mean_value(youtbis, yspan);
        white_noise_comm(iter)=find(youtbis(end,:)>thresh_min);
        biomass_final_1(white_noise_comm(iter),iter,1)=mean_value(white_noise_comm(iter));
end;

    dir_output='./output_simulation/season/';
%Filename for -SE-SND
extension='_noforcedcompetition_weightedinteraction.mat';
season_comm=zeros(1,100);
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    nb_species=nb_species(end);
        mean_value=species_mean_value(youtbis, yspan);
        season_comm(iter)=find(youtbis(end,:)>thresh_min);
        biomass_final_1(season_comm(iter),iter,2)=mean_value(season_comm(iter));
end;

figure;
subplot(2,2,1)
nb_alive=sum(biomass_final_1(:,:,1)'>0);
maxi=max(nb_alive);
mini=1;

nb_alive2=sum(biomass_final_1(:,:,2)'>0);
maxi2=max(nb_alive2);
mini=1;

hold on;

for s1=1:60
    if(nb_alive(s1)>0)
        tmp=biomass_final_1(s1,:,1);
        mean_tmp=mean(tmp(tmp>0));
        prop=(nb_alive(s1)-mini)/(maxi-mini);
        scatter(tau_opt(s1)-273,mean_tmp,20+80*prop,'o','MarkerFaceColor','b','MarkerEdgeColor','k','MarkerFaceAlpha',0.15+0.75*prop)
%  plot(tau_opt(s1)-273,biomass_final_1(s1,:,2),'o','MarkerFaceColor','r','MarkerEdgeColor','k')
    end
    if(nb_alive2(s1)>0)
        tmp=biomass_final_1(s1,:,2);
        mean_tmp=mean(tmp(tmp>0));
        prop=(nb_alive2(s1)-mini)/(maxi2-mini);
        scatter(tau_opt(s1)-273,mean_tmp,20+80*prop,'o','MarkerFaceColor','r','MarkerEdgeColor','k','MarkerFaceAlpha',0.15+0.75*prop)
%  plot(tau_opt(s1)-273,biomass_final_1(s1,:,2),'o','MarkerFaceColor','r','MarkerEdgeColor','k')
    end
end
    ylabel({"Intra=Inter";'Biomass'},'Fontsize',afontsize)
    
        tt1=title('No storage effect','Fontsize',afontsize,'FontWeight','Normal');
        titlePos = get( tt1 , 'position');
        titlePos(2)=858.6;
        set(tt1,'position',titlePos);
        set(gca,'Fontsize',afontsize)
hold off;

subplot(2,2,4)
mi1=prctile(biomass_final_60(:,:,1)',10);
ma1=prctile(biomass_final_60(:,:,1)',90);
mi2=prctile(biomass_final_60(:,:,2)',10);
ma2=prctile(biomass_final_60(:,:,2)',90);

plou1=[tau_opt fliplr(tau_opt)]-273;
minmax1=[mi1 fliplr(ma1)];
minmax2=[mi2 fliplr(ma2)];
hold on;
    fill(plou1,minmax1,'b','EdgeColor','none','FaceAlpha',.5)
    fill(plou1,minmax2,'r','EdgeColor','none','FaceAlpha',.5)
    xlabel("Thermal optimum","Fontsize",afontsize)
            set(gca,'Fontsize',afontsize)

hold off;

%%%%%%%%%%%%%%%%%%UNSTABLE CASES%%%%%%%%%%%%%%%%
dir_output='./output_simulation/white_noise/';
%Filename for +SE-SND
extension='.mat';

biomass_final_1=zeros(60,100,2);

for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_1(:,iter,1)=mean_value;
end;

dir_output='./output_simulation/season';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_1(:,iter,2)=mean_value;
end;

tmp=zeros(length(tau_opt),2,2);
for t=1:length(tau_opt)
    tmp(t,1,1)=prctile(biomass_final_1(t,:,1),10);
    tmp(t,2,1)=prctile(biomass_final_1(t,:,1),90);
       tmp(t,1,2)=prctile(biomass_final_1(t,:,2),10);
    tmp(t,2,2)=prctile(biomass_final_1(t,:,2),90); 
end

plou1=[tau_opt fliplr(tau_opt)]-273;
min_max_wn=[tmp(:,1,1)' fliplr(tmp(:,2,1)')];
min_max_seas=[tmp(:,1,2)' fliplr(tmp(:,2,2)')];

subplot(2,2,2)
hold on
fill(plou1,min_max_wn,'b','EdgeColor','none','FaceAlpha',.5)
fill(plou1,min_max_seas,'r','EdgeColor','none','FaceAlpha',.5)
ylim([0 400])
        tt1=title('Storage effect','Fontsize',afontsize,'FontWeight','Normal');
        titlePos = get( tt1 , 'position');
        titlePos(2)=430;
        set(tt1,'position',titlePos);
        set(gca,'Fontsize',afontsize)
hold off;

extension='_noforcedcompetition_10higherintra_weightedinteraction.mat';

biomass_final_2=zeros(60,100,2);
dir_output='./output_simulation/white_noise/';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_2(:,iter,1)=mean_value;
end;

dir_output='./output_simulation/season';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_2(:,iter,2)=mean_value;
end;

tmp=zeros(length(tau_opt),2,2);
for t=1:length(tau_opt)
    tmp(t,1,1)=prctile(biomass_final_2(t,:,1),10);
    tmp(t,2,1)=prctile(biomass_final_2(t,:,1),90);
       tmp(t,1,2)=prctile(biomass_final_2(t,:,2),10);
    tmp(t,2,2)=prctile(biomass_final_2(t,:,2),90); 
end

min_max_wn=[tmp(:,1,1)' fliplr(tmp(:,2,1)')];
min_max_seas=[tmp(:,1,2)' fliplr(tmp(:,2,2)')];

subplot(2,2,3)
hold on
fill(plou1,min_max_wn,'b','EdgeColor','none','FaceAlpha',.5)
fill(plou1,min_max_seas,'r','EdgeColor','none','FaceAlpha',.5)
    ylabel({"Intra>>Inter";'Biomass'},'Fontsize',afontsize)
    xlabel("Thermal optimum","Fontsize",afontsize)
    set(gca,'Fontsize',afontsize)
hold off;
fig=gcf;
fig.Renderer='Painters';
print(fig,'./Pres/Fig3_SFE','-depsc')