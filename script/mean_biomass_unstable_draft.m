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

subplot(1,2,1)
tmp=zeros(length(tau_opt),2);
for t=1:length(tau_opt)
    tmp(t,1)=min(biomass_final_1(t,:,1));
    tmp(t,2)=max(biomass_final_1(t,:,1));
end
hold on
plou1=[tau_opt fliplr(tau_opt)]-273;
plou2=[tmp(:,1)' fliplr(tmp(:,2)')];
fill(plou1,plou2,'c','EdgeColor','none','FaceAlpha',.3)

%for iter=1:50
iter=7;
plot(tau_opt-273,biomass_final_1(:,iter,1),'-o','MarkerFaceColor','b','LineWidth',2)
%end

tmp=zeros(length(tau_opt),2);
for t=1:length(tau_opt)
    tmp(t,1)=min(biomass_final_1(t,:,2));
    tmp(t,2)=max(biomass_final_1(t,:,2));
end
plou2=[tmp(:,1)' fliplr(tmp(:,2)')];
fill(plou1,plou2,'r','EdgeColor','none','FaceAlpha',.3)
%for iter=1:50
iter=7;
     plot(tau_opt-273,biomass_final_1(:,iter,2),'-o','MarkerFaceColor','r','LineWidth',2)
%end
hold off;


subplot(1,2,2)
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

tmp=zeros(length(tau_opt),2);
for t=1:length(tau_opt)
    tmp(t,1)=min(biomass_final_2(t,:,1));
    tmp(t,2)=max(biomass_final_2(t,:,1));
end
hold on
plou1=[tau_opt fliplr(tau_opt)]-273;
plou2=[tmp(:,1)' fliplr(tmp(:,2)')];
fill(plou1,plou2,'c','EdgeColor','none','FaceAlpha',.3)

% for iter=1:49
%     subplot(7,7,iter)
%     hold on; 
%     plot(tau_opt,biomass_final_2(:,iter,1),'-b')
%         plot(tau_opt,biomass_final_2(:,iter,2),'-r')
%         hold off;
% end

%for iter=1:50
 iter=7;
plot(tau_opt-273,biomass_final_2(:,iter,1),'-o','MarkerFaceColor','b','LineWidth',2)
%end

tmp=zeros(length(tau_opt),2);
for t=1:length(tau_opt)
    tmp(t,1)=min(biomass_final_2(t,:,2));
    tmp(t,2)=max(biomass_final_2(t,:,2));
end
plou2=[tmp(:,1)' fliplr(tmp(:,2)')];
fill(plou1,plou2,'r','EdgeColor','none','FaceAlpha',.3)
%for iter=1:50
iter=7;
plot(tau_opt-273,biomass_final_2(:,iter,2),'-o','MarkerFaceColor','r','LineWidth',2)
%end
hold off;


