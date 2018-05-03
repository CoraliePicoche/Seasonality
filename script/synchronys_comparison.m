%%%Compare synchronys at the community-level for different sets of
%%%simulation

clear all;
close all;
clc;

for iter=1:50
%    tab_diff_temp=community_wide_indices(strcat('output_simulation/SV_same_temp/iter',num2str(ff),'_codeversion_20180228_theta0_competitonintrahigherthanextra.mat'));
    dir_output='./output_simulation/white_noise/';
    tab_diff_temp=community_wide_indices(strcat(dir_output,'iter',num2str(iter),'_codeversion_20180228_theta0_noforcedcompetition_10higherintra_weightedinteraction.mat'));
%for randomized temperatures in folder SV_different_temp, Loreau=[0 0.2]
    %and Gross=[-0.15.0] (no positive values)
    %Globally, all values were low
    %for regular SV16, Loreau is around 0.1 with peaks that can reach 0.9
    %Gross is centered on 0 and between -0.1 and 0.15

    figure;
    subplot(2,2,1);
    plot(1:size(tab_diff_temp,2),tab_diff_temp(1,:))
    title(strcat(['Loreau index, White Noise',num2str(iter)]),'Fontsize',16)
    pos = get(gca, 'Position');
    pos(1)=0.03;
    pos(2)=0.55;
    pos(3)=0.45;
    pos(4)=0.4;
    set(gca,'Position',pos,'Fontsize',14)
    
    subplot(2,2,3);
    plot(1:size(tab_diff_temp,2),tab_diff_temp(2,:))
    title('Gross index, White Noise','Fontsize',16)
       pos = get(gca, 'Position');
    pos(1)=0.03;
    pos(2)=0.05;
    pos(3)=0.45;
    pos(4)=0.4;
    set(gca,'Position',pos,'Fontsize',14)

 dir_output='./output_simulation/season/';    
    tab_diff_temp=community_wide_indices(strcat(dir_output,'iter',num2str(iter),'_codeversion_20180228_theta1p3_noforcedcompetition_10higherintra_weightedinteraction.mat'));
 
    subplot(2,2,2);
    plot(1:size(tab_diff_temp,2),tab_diff_temp(1,:))
        title(strcat(['Loreau index, Season',num2str(iter)]),'Fontsize',16)
    pos = get(gca, 'Position');
    pos(1)=0.525;
    pos(2)=0.55;
    pos(3)=0.45;
    pos(4)=0.4;
    set(gca,'Position',pos,'Fontsize',14)
    
    subplot(2,2,4);
    plot(1:size(tab_diff_temp,2),tab_diff_temp(2,:))
            title('Gross index, Season','Fontsize',16)
    pos = get(gca, 'Position');
    pos(1)=0.525;
    pos(2)=0.05;
    pos(3)=0.45;
    pos(4)=0.4;
    set(gca,'Position',pos,'Fontsize',14)
end;