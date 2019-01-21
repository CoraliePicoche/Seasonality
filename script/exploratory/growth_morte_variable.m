%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Boxplot for our stable cases (60 or 1 species)

clear all; close all; clc;
afontsize=8;
col=jet(60);

dir_output='./output_simulation/white_noise/morta_variable/';
%Filename for +SE+SND

T = readtable("output_simulation/growth_rate_analysis.txt","Delimiter",";");
max_growth_rate=table2array(T(:,1));
mean_growth_rate=table2array(T(:,3));

figure()
j=0;
for iter=1:100
    if (mod(iter,25)==1)&(iter>2)
        figure()
        j=1;
        subplot(5,5,j)
    else 
       j=j+1;
       subplot(5,5,j)
    end;

    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228.mat');
    load(filename)
    m_iter=morta_vect;
    rm_iter=mean_growth_rate-morta_vect;
    rm_iter(1)
    rmaxm_iter=max_growth_rate-morta_vect;
    hold on;
%    plot(1:60,rm_iter);
    plot(1:60,m_iter,'+k')
    title(iter)
    %plot(1:60,rmaxm_iter)
    hold off;
end;

