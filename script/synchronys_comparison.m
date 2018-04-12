%%%Compare synchronys at the community-level for different sets of
%%%simulation

clear all;
close all;
clc;

%for ff=1:10
%    tab_diff_temp=community_wide_indices(strcat('output_simulation/SV_same_temp/iter',num2str(ff),'_codeversion_20180228_theta0_competitonintrahigherthanextra.mat'));

    tab_diff_temp=community_wide_indices(strcat('output_simulation/SV_same_temp/iter1_codeversion_20180228_theta0.mat'));
%for randomized temperatures in folder SV_different_temp, Loreau=[0 0.2]
    %and Gross=[-0.15.0] (no positive values)
    %Globally, all values were low
    %for regular SV16, Loreau is around 0.1 with peaks that can reach 0.9
    %Gross is centered on 0 and between -0.1 and 0.15

    figure;
    subplot(2,2,1);
    plot(1:size(tab_diff_temp,2),tab_diff_temp(1,:))
    title('Loreau index, Same temp','Fontsize',16)
    pos = get(gca, 'Position');
    pos(1)=0.03;
    pos(2)=0.55;
    pos(3)=0.45;
    pos(4)=0.4;
    set(gca,'Position',pos,'Fontsize',14)
    
    subplot(2,2,3);
    plot(1:size(tab_diff_temp,2),tab_diff_temp(2,:))
    title('Gross index, Same temp','Fontsize',16)
       pos = get(gca, 'Position');
    pos(1)=0.03;
    pos(2)=0.05;
    pos(3)=0.45;
    pos(4)=0.4;
    set(gca,'Position',pos,'Fontsize',14)

    
    tab_diff_temp=community_wide_indices(strcat('output_simulation/SV_different_temp/11essai.mat'));
 
    subplot(2,2,2);
    plot(1:size(tab_diff_temp,2),tab_diff_temp(1,:))
        title('Loreau index, Diff temp','Fontsize',16)
    pos = get(gca, 'Position');
    pos(1)=0.525;
    pos(2)=0.55;
    pos(3)=0.45;
    pos(4)=0.4;
    set(gca,'Position',pos,'Fontsize',14)
    
    subplot(2,2,4);
    plot(1:size(tab_diff_temp,2),tab_diff_temp(2,:))
            title('Gross index, Diff temp','Fontsize',16)
    pos = get(gca, 'Position');
    pos(1)=0.525;
    pos(2)=0.05;
    pos(3)=0.45;
    pos(4)=0.4;
    set(gca,'Position',pos,'Fontsize',14)
%end;