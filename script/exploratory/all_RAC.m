%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% RAC for not-stable cases
clear all; close all; clc;
thresh_min=10^(-6);
yspan=200;
afontsize=13;
col=jet(60);

dir_output='./output_simulation/white_noise/';
%Filename for +SE-SND
extension='.mat';

for iter=1:50
        if mod(iter,10)==1
        if iter>1
          myplot_RAC(com0,{},{},{},jet(60))
        end
        i=1;
        com0=zeros(10,60);
        figure;
        else
            i=i+1;
        end
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    com0(i,:)=youtbis(end,:);
end;
% 
dir_output='./output_simulation/season';
for iter=1:50
        if mod(iter,10)==1
        if iter>1
          myplot_RAC(com0,{},{},{},jet(60))
        end
        i=1;
        com0=zeros(10,60);
        figure;
        else
            i=i+1;
        end
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    com0(i,:)=youtbis(end,:);
end;