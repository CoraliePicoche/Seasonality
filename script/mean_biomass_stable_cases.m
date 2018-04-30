%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Boxplot for our stable cases (60 or 1 species)

clear all; close all; clc;
thresh_min=10^(-6);
yspan=200;
afontsize=20;
col=jet(60);

dir_output='./output_simulation/white_noise/';
%Filename for +SE+SND
extension='_10higher.mat';

biomass_final_60=zeros(60,50,2);

for iter=1:50
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_60(:,iter,1)=mean_value;
end;

dir_output='./output_simulation/season';
for iter=1:50
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_60(:,iter,2)=mean_value;
end;


subplot(2,1,1)
    boxplot(biomass_final_60(:,:,1)','BoxStyle','filled','Colors',col,'whisker',1000)
    maxi=get(gca,'Ylim');
maxi=maxi(2);
text(2,0.95*maxi,'c','Fontsize',afontsize)
    %ylim([mini maxi])
    box off;
%left bottom width height
    pos = get(gca, 'Position');
    pos(2)=0.57;
    pos(4)=0.32;
    pos(1)=0.18;
    title('60 species (+SE+SND)','Fontsize',afontsize);
    set(gca,'Position',pos,'Fontsize',afontsize,'xtick',[])

    subplot(2,1,2)
        boxplot(biomass_final_60(:,:,2)','BoxStyle','filled','Colors',col,'whisker',1000) 
            maxi=get(gca,'Ylim');
maxi=maxi(2);
text(2,0.95*maxi,'d','Fontsize',afontsize)

        xticklabels(tau_opt-273)       %ylim([mini maxi])
        xaxlabel=cell(1,length(tau_opt));
        xaxlabel(1:4:length(tau_opt))=sprintfc("%.1f",tau_opt(1:4:length(tau_opt))-273);
        set(gca,'XTickLabel',xaxlabel)
        xtickangle(90)
            pos = get(gca, 'Position');
            pos(1)=0.17;
            pos(2)=0.165;
   pos(4)=0.32;
    set(gca,'Position',pos,'Fontsize',afontsize)
box off;
fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./Rapport/graphe/60species','-dpdf')



dir_output='./output_simulation/white_noise/';
%Filename for -SE-SND
extension='_noforcedcompetition_weightedinteraction.mat';
white_noise_comm=zeros(1,50);
biomass_final_1=zeros(60,50,2);
for iter=1:50
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    nb_species=nb_species(end);
    if nb_species>1
        filename
        nb_species
        youtbis(end,:)
    else
        mean_value=species_mean_value(youtbis, yspan);
        white_noise_comm(iter)=find(youtbis(end,:)>thresh_min);
        biomass_final_1(white_noise_comm(iter),iter,1)=mean_value(white_noise_comm(iter));
    end;
end;

    dir_output='./output_simulation/season/';
%Filename for -SE-SND
extension='_noforcedcompetition_weightedinteraction.mat';
season_comm=zeros(1,50);
for iter=1:50
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    nb_species=nb_species(end);
    if nb_species>1
        filename
        nb_species
        youtbis(end,:)
    else
        mean_value=species_mean_value(youtbis, yspan);
        season_comm(iter)=find(youtbis(end,:)>thresh_min);
        biomass_final_1(season_comm(iter),iter,2)=mean_value(season_comm(iter));
    end;
end;

figure
subplot(2,1,1)
hold on
for s1=1:60
 plot(tau_opt(s1)-273,biomass_final_1(s1,:,1),'o','MarkerFaceColor',col(s1,:),'MarkerEdgeColor','k')
end
xlim([min(tau_opt)-273-0.5 max(tau_opt)-273+0.5])
ylim([750 850])
    ylabel('Biomass')
box off
text(14.9,845,'a','Fontsize',afontsize)

hold off;
    pos = get(gca, 'Position');
    pos(2)=0.57;
    pos(4)=0.32;
    pos(1)=0.17;
        title('1 species (-SE-SND)','Fontsize',afontsize);
    set(gca,'Position',pos,'Fontsize',afontsize,'xtick',[])
   
subplot(2,1,2)
hold on
for s1=1:60
 plot(tau_opt(s1)-273,biomass_final_1(s1,:,2),'o','MarkerFaceColor',col(s1,:),'MarkerEdgeColor','k')
end
xlim([min(tau_opt)-273-0.5 max(tau_opt)-273+0.5])
ylim([750 850])

    ylabel('Biomass')
box off
text(14.9,845,'b','Fontsize',afontsize)

hold off;
        xtick(tau_opt-273)
        %ylim([mini maxi])
        set(gca,'XTickLabel',xaxlabel)
        xtickangle(90)
            pos = get(gca, 'Position');
            pos(2)=0.165;
   pos(4)=0.32;
   pos(1)=0.17;
    set(gca,'Position',pos,'Fontsize',afontsize)
box off;
fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./Rapport/graphe/1species','-dpdf')
