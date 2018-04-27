%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Boxplot for the not-so-stable cases

clear all; close all; clc;
thresh_min=10^(-6);
yspan=200;
afontsize=13;
col=jet(60);

dir_output='./output_simulation/white_noise/';
%Filename for +SE-SND
extension='.mat';

biomass_final_1=zeros(60,50,2);

for iter=1:50
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_1(:,iter,1)=mean_value;
end;

dir_output='./output_simulation/season';
for iter=1:50
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_1(:,iter,2)=mean_value;
end;

figure
subplot(1,1,1)
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

fill(plou1,min_median_season,'r','EdgeColor','none','FaceAlpha',.3) %Interesting : you have only one peak here
fill(plou1,median_90_season,'r','EdgeColor','none','FaceAlpha',.5)
fill(plou1,nin_max_season,'r','EdgeColor','none','FaceAlpha',.7)
%for iter=1:50
iter=7;
     plot(tau_opt-273,biomass_final_1(:,iter,1),'-o','MarkerFaceColor','b','LineWidth',2,'color','b')
plot(tau_opt-273,biomass_final_1(:,iter,2),'-o','MarkerFaceColor','r','LineWidth',2,'color','r')
%end
hold off;
set(gca,'Fontsize',14)

figure
subplot(1,1,1)
extension='_noforcedcompetition_10higherintra_weightedinteraction.mat';

biomass_final_2=zeros(60,50,2);
dir_output='./output_simulation/white_noise/';
for iter=1:50
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_2(:,iter,1)=mean_value;
end;

dir_output='./output_simulation/season';
for iter=1:50
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
set(gca,'Fontsize',14)
%end
hold off;


