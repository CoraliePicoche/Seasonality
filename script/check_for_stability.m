%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Check for convergence in the saved files, based on species richness,
%%% total abundance over a cycle, maximum biomass of each species over a
%%% cycle and coefficent of variation of the total biomass (inspired by
%%% Sakavara et al. PNAS 2018. Still needs to be implemented : for now,
%%% only species richness is ok


clear all; clc; close all;

thresh_min=10^(-6);
alpha=0.001;

adir='./output_simulation/season/';
allfiles=dir(adir);
fileNames = {allfiles(~[allfiles.isdir]).name};
 for f=1:length(fileNames)
     subplot(3,4,f)
    load(strcat([adir,fileNames{f}]));
    nb_species=sum(youtbis'>thresh_min);
    tot_abundance=sum(youtbis');
%    plot((1:length(nb_species))/365,nb_species)
    plot((1:length(nb_species))/365,tot_abundance)
%    ylim([10 21])
 end;