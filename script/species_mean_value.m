%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Function to compute species-specific mean values


function res=species_mean_value(youtbis, varargin)
    S=size(youtbis,2); %number of species
    tt=size(youtbis,1);
    optargs={200}; %corresponidng to default value for ywindow, yspan and alpha, respectively
    thresh_min=10^(-6);
    
    num_argin=length(varargin);
    optargs(1:num_argin)=varargin;
    yspan=optargs{1};   
    if yspan>tt/365
       error('Size of the window is larger than the simulation')
    end
   
    ymax=tt; %année max-3 to be able to compute the average
    ymin=ymax-yspan*365+1; %we want 200 years of simulations
    new_youtbis=youtbis(ymin:ymax,:);
    
    mask=youtbis(end,:)<thresh_min;
    sbis=1:S;
    sbis=sbis(~mask); %extant species
    ymean=zeros(1,S);
    for s1=sbis
        ymean(s1)=mean(new_youtbis(:,s1));
    end
    res=ymean;
end