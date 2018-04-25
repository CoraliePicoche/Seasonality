%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Just checking that we have the same results (same number of extant
%%% species, same extant species) for the cases +SE+SND and -SE-SND

clear all; close all; clc;
thresh_min=10^(-6);

dir_output='./output_simulation/white_noise/';
%Filename for +SE+SND
extension='_10higher.mat';

for iter=1:50
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    nb_species=nb_species(end);
    if nb_species<60
        filename
        nb_species
    end;
end;

dir_output='./output_simulation/season';
for iter=1:50
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    nb_species=sum(youtbis'>thresh_min);
    nb_species=nb_species(end);
    if nb_species<60
        filename
    end;
end;


dir_output='./output_simulation/white_noise/';
%Filename for -SE-SND
extension='_noforcedcompetition_weightedinteraction.mat';
white_noise_comm=zeros(1,50);
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
        white_noise_comm(iter)=find(youtbis(end,:)>thresh_min);
    end;
end;

dir_output='./output_simulation/season/';
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
        season_comm(iter)=find(youtbis(end,:)>thresh_min);
    end;
end;

