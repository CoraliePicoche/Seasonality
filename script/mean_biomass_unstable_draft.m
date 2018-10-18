%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Boxplot for the not-so-stable cases

clear all; close all; clc;
thresh_min=10^(-6);
yspan=200;
afontsize=10;
col=jet(60);

subplot_id=zeros(1,2);

T = readtable("output_simulation/growth_rate_analysis.txt","Delimiter",";");
max_growth_rate=table2array(T(:,1));
mean_growth_rate=table2array(T(:,3));

max_growth_rate=max_growth_rate/max(max_growth_rate);
mean_growth_rate=mean_growth_rate/max(mean_growth_rate);

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

% tmp=zeros(length(tau_opt),2);
% for t=1:length(tau_opt)
%     tmp(t,1)=min(biomass_final_1(t,:,1));
%     tmp(t,2)=max(biomass_final_1(t,:,1));
% end
% hold on
% plou1=[tau_opt fliplr(tau_opt)]-273;
% plou2=[tmp(:,1)' fliplr(tmp(:,2)')];
% fill(plou1,plou2,'c','EdgeColor','none','FaceAlpha',.3)


tmp=zeros(length(tau_opt),4,2);
for t=1:length(tau_opt)
    tmp(t,1,1)=min(biomass_final_1(t,:,1));
    tmp(t,2,1)=max(biomass_final_1(t,:,1));
    tmp(t,3,1)=prctile(biomass_final_1(t,:,1),50);
    tmp(t,4,1)=prctile(biomass_final_1(t,:,1),90);
    tmp(t,1,2)=min(biomass_final_1(t,:,2));
    tmp(t,2,2)=max(biomass_final_1(t,:,2));
    tmp(t,3,2)=prctile(biomass_final_1(t,:,2),50);
    tmp(t,4,2)=prctile(biomass_final_1(t,:,2),90);    
end

%Feeling fancy
plou1=[tau_opt fliplr(tau_opt)]-273;
min_median_wn=[tmp(:,1,1)' fliplr(tmp(:,3,1)')];
median_90_wn=[tmp(:,3,1)' fliplr(tmp(:,4,1)')];
nin_max_wn=[tmp(:,4,1)' fliplr(tmp(:,2,1)')];

min_median_season=[tmp(:,1,2)' fliplr(tmp(:,3,2)')];
median_90_season=[tmp(:,3,2)' fliplr(tmp(:,4,2)')];
nin_max_season=[tmp(:,4,2)' fliplr(tmp(:,2,2)')];
fig=figure;
set(fig,'defaultAxesColorOrder',[[0 0 0]; [0 0 0]]);
subplot(2,1,1)
hold on

yyaxis left;
fill(plou1,min_median_wn,'b','EdgeColor','none','FaceAlpha',.3)
fill(plou1,median_90_wn,'b','EdgeColor','none','FaceAlpha',.5)
fill(plou1,nin_max_wn,'b','EdgeColor','none','FaceAlpha',.7)

fill(plou1,min_median_season,'r','EdgeColor','none','FaceAlpha',.3) %Interesting : you have only one peak here
fill(plou1,median_90_season,'r','EdgeColor','none','FaceAlpha',.5)
fill(plou1,nin_max_season,'r','EdgeColor','none','FaceAlpha',.7)
%for iter=1:50
iter=7;
     plot(tau_opt-273,biomass_final_1(:,iter,1),'-o','MarkerFaceColor','b','LineWidth',2,'color','b')
plot(tau_opt-273,biomass_final_1(:,iter,2),'-o','MarkerFaceColor','r','LineWidth',2,'color','r')
      xticks(tau_opt(1:9:length(tau_opt))-273)     
        xaxlabel=cell(1,length(tau_opt));
        %xaxlabel(1:4:length(tau_opt))=sprintfc("%.1f",tau_opt(1:4:length(tau_opt))-273);
        set(gca,'XTickLabel',xaxlabel)
        xtickangle(90)
%end
subplot_id(1)=ylabel({"Storage effect";'Biomass'});
set(gca,'Fontsize',afontsize)

yyaxis right;
plot(tau_opt-273,max_growth_rate,'o','MarkerEdgeColor','k','MarkerSize',3)
plot(tau_opt-273,mean_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',3)
id=find(mean_growth_rate==1);
ylabel('Growth rate','Fontsize',afontsize);
ylim([0 1.1])

text(15.1,1.*0.95,'a','Fontsize',afontsize)
plot([tau_opt(id) tau_opt(id)]-273,[0 mean_growth_rate(id)],'--k','LineWidth',2)
hold off;
% fig.PaperPositionMode = 'auto'
% fig_pos = fig.PaperPosition;
% fig.PaperSize = [fig_pos(3) fig_pos(4)];
% print(fig,'./Rapport/graphe/fancy_distrib_YesSE_NoSND','-dtiff')
pos=get(gca,'Position')
set(gca,'Position',pos)
subplot(2,1,2)
% 
% set(fig,'defaultAxesColorOrder',[[0 0 0]; [0 0 0]]);
% subplot(1,1,1)
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

tmp=zeros(length(tau_opt),4,2);
for t=1:length(tau_opt)
    tmp(t,1,1)=min(biomass_final_2(t,:,1));
    tmp(t,2,1)=max(biomass_final_2(t,:,1));
    tmp(t,3,1)=prctile(biomass_final_2(t,:,1),50);
    tmp(t,4,1)=prctile(biomass_final_2(t,:,1),90);
    tmp(t,1,2)=min(biomass_final_2(t,:,2));
    tmp(t,2,2)=max(biomass_final_2(t,:,2));
    tmp(t,3,2)=prctile(biomass_final_2(t,:,2),50);
    tmp(t,4,2)=prctile(biomass_final_2(t,:,2),90);    
end
hold on

%Feeling fancy
plou1=[tau_opt fliplr(tau_opt)]-273;
min_median_wn=[tmp(:,1,1)' fliplr(tmp(:,3,1)')];
median_90_wn=[tmp(:,3,1)' fliplr(tmp(:,4,1)')];
nin_max_wn=[tmp(:,4,1)' fliplr(tmp(:,2,1)')];

min_median_season=[tmp(:,1,2)' fliplr(tmp(:,3,2)')];
median_90_season=[tmp(:,3,2)' fliplr(tmp(:,4,2)')];
nin_max_season=[tmp(:,4,2)' fliplr(tmp(:,2,2)')];

fill(plou1,min_median_wn,'b','EdgeColor','none','FaceAlpha',.3)
fill(plou1,median_90_wn,'b','EdgeColor','none','FaceAlpha',.5)
fill(plou1,nin_max_wn,'b','EdgeColor','none','FaceAlpha',.7)

fill(plou1,min_median_season,'r','EdgeColor','none','FaceAlpha',.3)
fill(plou1,median_90_season,'r','EdgeColor','none','FaceAlpha',.5)
fill(plou1,nin_max_season,'r','EdgeColor','none','FaceAlpha',.7)

% tmp=zeros(length(tau_opt),2);
% for t=1:length(tau_opt)
%     tmp(t,1)=min(biomass_final_2(t,:,1));
%     tmp(t,2)=max(biomass_final_2(t,:,1));
% end
% hold on
% plou1=[tau_opt fliplr(tau_opt)]-273;
% plou2=[tmp(:,1)' fliplr(tmp(:,2)')];
% fill(plou1,plou2,'c','EdgeColor','none','FaceAlpha',.3)

% for iter=1:49
%     subplot(7,7,iter)
%     hold on; 
%     plot(tau_opt,biomass_final_2(:,iter,1),'-b')
%         plot(tau_opt,biomass_final_2(:,iter,2),'-r')
%         hold off;
% end

%for iter=1:50
 iter=7;
plot(tau_opt-273,biomass_final_2(:,iter,1),'-o','MarkerFaceColor','b','LineWidth',2,'color','b')
%end

% tmp=zeros(length(tau_opt),2);
% for t=1:length(tau_opt)
%     tmp(t,1)=min(biomass_final_2(t,:,2));
%     tmp(t,2)=max(biomass_final_2(t,:,2));
% end
% plou2=[tmp(:,1)' fliplr(tmp(:,2)')];
%fill(plou1,plou2,'r','EdgeColor','none','FaceAlpha',.3)
%for iter=1:50
iter=7;
plot(tau_opt-273,biomass_final_2(:,iter,2),'-o','MarkerFaceColor','r','LineWidth',2,'color','r')
      xticks(tau_opt(1:9:length(tau_opt))-273)       %ylim([mini maxi])%        xaxlabel=cell(1,length(tau_opt));
           xaxlabel=sprintfc("%.1f",tau_opt(1:9:length(tau_opt))-273);
        xlabel('Thermal optimum','Fontsize',afontsize)
        set(gca,'XTickLabel',xaxlabel)
       %  xtickangle(90)
subplot_id(2)=ylabel({"Strong Self-Regulation";'Biomass'},'Fontsize',afontsize);
set(gca,'Fontsize',afontsize)
%end

yyaxis right;
plot(tau_opt-273,max_growth_rate,'o','MarkerEdgeColor','k','MarkerSize',3)
plot(tau_opt-273,mean_growth_rate,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',3)
ylabel('Growth rate','Fontsize',afontsize);
ylim([0 1.1])
text(15.1,1*0.95,'b','Fontsize',afontsize)

id=find(mean_growth_rate==1);
plot([tau_opt(id) tau_opt(id)]-273,[0 mean_growth_rate(id)],'--k','LineWidth',2)

pos=get(gca,'Position');
pos(4)=0.35;
pos(2)=0.19;
set(gca,'Position',pos)
positions = cell2mat(get(subplot_id([1 2]), 'Position'));
xpos = min(positions(:,1))-0.025;
for i=[1 2]
    set(subplot_id(i), 'Position',[xpos, positions(i,2), positions(i,3)]);
end
hold off;
pos=get(gca,'Position');
pos(2)=0.11;
set(gca,'Position',pos)

set(fig,'Position',[680 558 520 420])
fig.Renderer='Painters';
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./article/graphe/Fig4','-depsc')


%
% id_min=60;
% id_max=zeros(1,100);
% for iter=1:100
%     min_tmp=min(find(biomass_final_2(:,iter,2)>thresh_min))
%     if id_min>min_tmp
%         id_min=min_tmp;
%     end;
%         id_max(iter)=max(find(biomass_final_2(:,iter,2)>thresh_min));
% end
% 
% tau_tmp=zeros(1,length(tau_opt));
% for s1=1:60
% tau_tmp(s1)=sum(biomass_final_1(s1,:,2)>0);
% end;


