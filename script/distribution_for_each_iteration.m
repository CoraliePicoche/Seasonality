%%% Ugly plot, just to have all iterations in front of me
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

for iter=1:49
    subplot(7,7,iter)
    hold on
plot(tau_opt-273,biomass_final_1(:,iter,1),'-o','MarkerFaceColor','b')
plot(tau_opt-273,biomass_final_1(:,iter,2),'-o','MarkerFaceColor','r')
title(num2str(iter))
hold off
end
iter=50;

figure
subplot(1,1,1)

hold on
plot(tau_opt-273,biomass_final_1(:,iter,1),'-o','MarkerFaceColor','b')
plot(tau_opt-273,biomass_final_1(:,iter,2),'-o','MarkerFaceColor','r')
title(num2str(iter))
hold off

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
figure
for iter=1:49
    subplot(7,7,iter)
    hold on
plot(tau_opt-273,biomass_final_2(:,iter,1),'-o','MarkerFaceColor','b')
plot(tau_opt-273,biomass_final_2(:,iter,2),'-o','MarkerFaceColor','r') 
plot([20 20],[0 50],'-k') %corresponds to the mean value of tau
plot([tau_opt(33)-273 tau_opt(33)-273],[0 50],'--k') %corresponds to the max of the mean values of r
title(num2str(iter))
hold off
end

figure
subplot(1,1,1)
iter=50;
hold on
plot(tau_opt-273,biomass_final_2(:,iter,1),'-o','MarkerFaceColor','b')
plot(tau_opt-273,biomass_final_2(:,iter,2),'-o','MarkerFaceColor','r')
title(num2str(iter))
plot([20 20],[0 50],'-k')
plot([tau_opt(33)-273 tau_opt(33)-273],[0 50],'--k')
hold off
