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



%fig = gcf;
% fig.PaperPositionMode = 'auto'
% fig_pos = fig.PaperPosition;
% fig.PaperSize = [fig_pos(3) fig_pos(4)];
% print(fig,'./Rapport/graphe/60species','-dpdf')



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

%figure
subplot(2,2,1)
hold on
for s1=1:60
 plot(tau_opt(s1)-273,biomass_final_1(s1,:,1),'o','MarkerFaceColor',col(s1,:),'MarkerEdgeColor','k')
end

tau_tmp=zeros(1,length(tau_opt));
for s1=1:60
    tau_tmp(s1)=sum(biomass_final_1(s1,:,1)>0);
end;
xlim([min(tau_opt)-273-0.5 max(tau_opt)-273+0.5])
ylim([750 850])
    ylabel('Biomass')
   
box off
text(14.9,845,'a','Fontsize',afontsize)

hold off;
    pos = get(gca, 'Position')
     pos(1)=0.09;
     pos(2)=0.58;
     pos(3)=0.42;
     pos(4)=0.34;
        title('1 species (-storage-SND)','Fontsize',afontsize);
    set(gca,'Position',pos,'Fontsize',afontsize,'xtick',[])
   
subplot(2,2,3)
hold on
for s1=1:60
 plot(tau_opt(s1)-273,biomass_final_1(s1,:,2),'o','MarkerFaceColor',col(s1,:),'MarkerEdgeColor','k')
end
xlim([min(tau_opt)-273-0.5 max(tau_opt)-273+0.5])
ylim([750 850])

    ylabel('Biomass')
    xlabel('Thermal optimum')
box off
text(14.9,845,'c','Fontsize',afontsize)

hold off;
        xtick(tau_opt-273)
        %ylim([mini maxi
        xaxlabel=cell(1,length(tau_opt));
        xaxlabel(1:4:length(tau_opt))=sprintfc("%.1f",tau_opt(1:4:length(tau_opt))-273);
        
        set(gca,'XTickLabel',xaxlabel)
        
        xtickangle(90)
            pos = get(gca, 'Position')
     pos(1)=0.09;
     pos(2)=0.17;
     pos(3)=0.42;
     pos(4)=0.34;
    set(gca,'Position',pos,'Fontsize',afontsize)
box off;

subplot(2,2,2)
    boxplot(biomass_final_60(:,:,1)','BoxStyle','filled','Colors',col,'whisker',1000)
    maxi=get(gca,'Ylim');
maxi=maxi(2);
text(2,0.95*maxi,'b','Fontsize',afontsize)
    %ylim([mini maxi])
    box off;
%left bottom width height
    pos = get(gca, 'Position')
     pos(1)=0.57;
     pos(2)=0.58;
     pos(3)=0.42;
     pos(4)=0.34;

    title('60 species (+storage+SND)','Fontsize',afontsize);
    set(gca,'Position',pos,'Fontsize',afontsize,'xtick',[])

    subplot(2,2,4)
        boxplot(biomass_final_60(:,:,2)','BoxStyle','filled','Colors',col,'whisker',1000) 
            maxi=get(gca,'Ylim');
maxi=maxi(2);
text(2,12.75,'d','Fontsize',afontsize)

        xticklabels(tau_opt-273)       %ylim([mini maxi])
        set(gca,'XTickLabel',xaxlabel)
        xtickangle(90)
            pos = get(gca, 'Position')
             pos(1)=0.57;
             pos(3)=0.42;
             pos(2)=0.17;
    pos(4)=0.34;
            xlabel('Thermal optimum')

    set(gca,'Position',pos,'Fontsize',afontsize)
box off;


fig = gcf;
set(gcf,'Position',[675 549 1100 600])
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./Rapport/graphe/60_and_1species','-dpdf')

%
id_min=60;
id_max=0;

for iter=1:50
    min_tmp=find(biomass_final_1(:,iter,1)>thresh_min);
    if id_min>min_tmp
        id_min=min_tmp;
    end;
    if id_max<min_tmp
        id_max=min_tmp;
    end
end


%Few tests
% tau_tmp=zeros(1,length(tau_opt));
% for s1=1:60
% tau_tmp(s1)=sum(biomass_final_1(s1,:,2)>0);
% end;
%median(std(biomass_final_60(:,:,1),[],2)./mean(biomass_final_60(:,:,1),2))

% for f=1:60
%     f
%     mean(biomass_final_60(f,:,2),2)
% end
% %f=13 and f=57