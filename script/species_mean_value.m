%%% Model first developped by of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Script by Picoche & Barraquand 2018
%%% This function computes species mean biomass during the last years of
%%% the simulation


function res=species_mean_value(youtbis, varargin)
    S=size(youtbis,2); %number of species
    tt=size(youtbis,1); %length of the simulation
    optargs={200}; %corresponding to default value for yspan
    thresh_min=10^(-6); %threshold below which species are considered extunct and set to 0
    
    num_argin=length(varargin);
    optargs(1:num_argin)=varargin;
    yspan=optargs{1};   
    if yspan>tt/365
       error('Size of the window is larger than the simulation')
    end
    
    %Only uses the given timespan to compute the mean biomass
    ymax=tt;
    ymin=ymax-yspan*365+1; %we want yspan years of simulations
    new_youtbis=youtbis(ymin:ymax,:);
    
    mask=youtbis(end,:)<thresh_min; %Remove species that are extant at the end of the simulation
    sbis=1:S;
    sbis=sbis(~mask); %extant species
    ymean=zeros(1,S);
    for s1=sbis
        ymean(s1)=mean(new_youtbis(:,s1));
    end
    res=ymean;
end