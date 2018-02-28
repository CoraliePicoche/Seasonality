%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Check for convergence in the saved files, based on species richness,
%%% total abundance over a cycle, maximum biomass of each species over a
%%% cycle and coefficent of variation of the total biomass (inspired by
%%% Sakavara et al. PNAS 2018.)
%%% Also added the coefficient of variation -over a year, which does not
%%% really make sense when we have no noise, but we could expect it
%%% to keep similar values if the model stabilizes, right?-


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
    biomass_over_year=reshape(youtbis,365,size(youtbis,1)/365,size(youtbis,2)); % x = julian day ; y = year ; z species
    total_biomass_cycle=cumsum(biomass_over_year,1); %total biomass over a cycle
    total_biomass_cycle=reshape(total_biomass_cycle(365,:,:),size(youtbis,1)/365,size(youtbis,2));
    max_biomass_cycle=max(biomass_over_year,[],1); % maximum biomass over a cycle
    max_biomass_cycle=reshape(max_biomass_cycle(1,:,:),size(youtbis,1)/365,size(youtbis,2));
    cv_cycle=std(biomass_over_year,[],1)./mean(biomass_over_year,1); % coefficient of variation over a year
    cv_cycle=reshape(cv_cycle(1,:,:),size(youtbis,1)/365,size(youtbis,2));
    %We can also consider the coefficient of variation for total biomass
    tt_biomass=cumsum(biomass_over_year,3);
    cv_cycle=std(total_biomass_cycle(:,:,60),[],1)./mean(total_biomass_cycle(:,:,60),1); 
    
    
    plot((1:length(nb_species))/365,nb_species)
    ylim([10 21])
 end;