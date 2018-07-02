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

T = readtable("output_simulation/growth_rate_analysis.txt","Delimiter",";");
max_growth_rate=table2array(T(:,1));
mean_growth_rate=table2array(T(:,3));

max_growth_rate=max_growth_rate/max(max_growth_rate);
mean_growth_rate=mean_growth_rate/max(mean_growth_rate);


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



%fig = gcf;
% fig.PaperPositionMode = 'auto'
% fig_pos = fig.PaperPosition;
% fig.PaperSize = [fig_pos(3) fig_pos(4)];
% print(fig,'./Rapport/graphe/60species','-dpdf')



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
season_comm=zeros(1,100);
for iter=1:100
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
fig=figure;
set(fig,'defaultAxesColorOrder',[[0 0 0]; [0 0 0]]);

subplot(2,2,1)
hold on
%yyaxis left
for s1=1:60
 plot(tau_opt(s1)-273,biomass_final_1(s1,:,1),'o','MarkerFaceColor',col(s1,:),'MarkerEdgeColor','k')
end

tau_tmp=zeros(1,length(tau_opt));
for s1=1:60
    tau_tmp(s1)=sum(biomass_final_1(s1,:,1)>0);
end;
xlim([min(tau_opt)-273 max(tau_opt)-273+0.1])
ylim([750 850])
    ylabel('Biomass')
 
   
box off
text(15.15,845,'a','Fontsize',afontsize)

yyaxis right;
plot(tau_opt-273,max_growth_rate,'o','MarkerEdgeColor','k','MarkerSize',3)
plot(tau_opt-273,mean_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',3)

hold off;
    pos = get(gca, 'Position')
     pos(1)=0.09;
     pos(2)=0.58;
     pos(3)=0.38;
     pos(4)=0.34;
        tt1=title('1 species (-storage-SND)','Fontsize',afontsize,'FontWeight','Normal');
        titlePos = get( tt1 , 'position');
        titlePos(2)=858.6;
        set(tt1,'position',titlePos);
    set(gca,'Position',pos,'Fontsize',afontsize,'xtick',[])%,'ytick',[])
   
subplot(2,2,3)
hold on
%yyaxis left
for s1=1:60
 plot(tau_opt(s1)-273,biomass_final_1(s1,:,2),'o','MarkerFaceColor',col(s1,:),'MarkerEdgeColor','k')
end
xlim([min(tau_opt)-273 max(tau_opt)-273+0.1])
ylim([750 850])

    ylabel('Biomass')
    xlabel('Thermal optimum')
box off
text(15.15,845,'c','Fontsize',afontsize)
yyaxis right;
plot(tau_opt-273,max_growth_rate,'o','MarkerEdgeColor','k','MarkerSize',3)
plot(tau_opt-273,mean_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',3)

hold off;
        xtick(tau_opt(1:9:length(tau_opt))-273)
        %ylim([mini maxi
   %     xaxlabel=cell(1,length(tau_opt));
        xaxlabel=sprintfc("%.1f",tau_opt(1:9:length(tau_opt))-273);
        
        set(gca,'XTickLabel',xaxlabel)%,'ytick',[])
        
 %       xtickangle(90)
            pos = get(gca, 'Position')
     pos(1)=0.09;
     pos(2)=0.17;
     pos(3)=0.38;
     pos(4)=0.34;
    set(gca,'Position',pos,'Fontsize',afontsize)
box off;

subplot(2,2,2)
%yyaxis left
    boxplot(biomass_final_60(:,:,1)','BoxStyle','filled','Colors',col,'whisker',1000)
    xlim([1 60.1])
    maxi=get(gca,'Ylim');
maxi=maxi(2);
text(2,0.95*maxi,'b','Fontsize',afontsize)
    %ylim([mini maxi])
    box off;
%left bottom width height
    pos = get(gca, 'Position')
     pos(1)=0.55;
     pos(2)=0.58;
     pos(3)=0.38;
     pos(4)=0.34;

    tt2=title('60 species (+storage+SND)','Fontsize',afontsize,'FontWeight','Normal');
            titlePos = get( tt2 , 'position');
            titlePos(2)=16.9;
        set(tt2,'position',titlePos);

        yyaxis right;
        hold on;
plot(1:60,max_growth_rate,'o','MarkerEdgeColor','k','MarkerSize',3)
plot(1:60,mean_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',3)
    ylabel('Scaled GR','Fontsize',afontsize)

hold off;
%         
    set(gca,'Position',pos,'Fontsize',afontsize,'xtick',[])

    subplot(2,2,4)
  %  yyaxis left
        boxplot(biomass_final_60(:,:,2)','BoxStyle','filled','Colors',col,'whisker',1000) 
        xlim([1 60.1])
    
            maxi=get(gca,'Ylim');
maxi=maxi(2);
text(2,12.75,'d','Fontsize',afontsize)
yyaxis right;
hold on;
plot(1:60,max_growth_rate,'o','MarkerEdgeColor','k','MarkerSize',3)
plot(1:60,mean_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',3)
    ylabel('Scaled GR','Fontsize',afontsize)

hold off;       
xtick(1:9:60)
        xticklabels(tau_opt(1:9:length(tau_opt))-273)       %ylim([mini maxi])
        set(gca,'XTickLabel',xaxlabel)
  %      xtickangle(90)
            pos = get(gca, 'Position')
             pos(1)=0.55;
             pos(3)=0.38;
             pos(2)=0.17;
    pos(4)=0.34;
            xlabel('Thermal optimum')


    set(gca,'Position',pos,'Fontsize',afontsize)
box off;


%fig = gcf;
set(gcf,'Position',[675 549 1250 600])
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./article/graphe/Fig3','-depsc')

%
% id_min=60;
% id_max=0;
% 
% for iter=1:50
%     min_tmp=find(biomass_final_1(:,iter,1)>thresh_min);
%     if id_mi[])
% 
%     subplot(2,2,4)
%   %  yyaxis left
%         boxplot(biomass_final_60(:,:,2)','BoxStyle','filled','Colors',col,'whisker',1000) 
%         xlim([1 60.1])
%     
%             maxi=get(gca,'Ylim');
% maxi=maxi(2);
% text(2,12.75,'d','Fontsize',afontsize)
% yyaxis right;
% hold on;
% plot(1:60,max_growth_rate,'o','MarkerEdgeColor','k','MarkerSize',3)
% plot(1:60,mean_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',3)
%     ylabel('Normalized growth rate','Fontsize',afontsize)
% 
% hold off;       
% xtick(1:9:60)
%         xticklabels(tau_opt(1:9:length(tau_opt))-273)       %ylim([mini maxi])
%         set(gca,'XTickLabel',xaxlabel)
%   %      xtickangle(90)
%             pos = get(gca, 'Position')
%              pos(1)=0.55;
%              pos(3)=0.41;
%              pos(2)=0.17;
%     pos(4)=0.34;
%             xlabel('Thermal optimum')
% 
% 
%     set(gca,'Position',pos,'Fontsize',afontsize)
% box off;
% 
% 
% %fig = gcf;
% set(gcf,'Position',[675 549 1250 600])
% fig.PaperPositionMode = 'auto'
% fig_pos = fig.PaperPosition;
% fig.PaperSize = [fig_pos(3) fig_pos(4)];
% print(fig,'./article/graphe/Fig3','-depsc')
% 
% %
% id_min=60;
% id_max=0;
% 
% for iter=1:50
%     min_tmp=find(biomass_final_1(:,iter,1)>thresh_min);
%     if id_min>min_tmp
%         id_min=min_tmp;
%     end;
%     if id_max<min_tmp
%         id_max=min_tmp;
%     end
% end
% 
% 
% %Few tests
% tau_tmp=zeros(1,length(tau_opt));
%  for s1=1:60
%  tau_tmp(s1)=sum(biomass_final_1(s1,:,2)>0);
%  end;
%  median(std(biomass_final_60(:,:,1),[],2)./mean(biomass_final_60(:,:,1),2))
% 
% % for f=1:60
% %     f
% %     mean(biomass_final_60(f,:,2),2)
% % end
% % %f=13 and f=57