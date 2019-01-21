%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Function to check stability, given youtbis

function convergence_function(youtbis)
    thresh_min=10^(-6);
    %First assessments
    nb_species=sum(youtbis'>thresh_min);
    nb_species_final=nb_species(end)
    tot_biomass_final=mean(sum(youtbis((end-364):end,:),2))
    
    biomass_over_year=reshape(youtbis,365,size(youtbis,1)/365,size(youtbis,2)); % x = julian day ; y = year ; z species
    %We can also consider the coefficient of variation for total biomass
    tt_biomass=cumsum(biomass_over_year,3);
    %cv_cycle=std(total_biomass_cycle(:,:,60),[],1)./mean(total_biomass_cycle(:,:,60),1);
    cv_cycle=std(tt_biomass(:,:,60),[],1)./mean(tt_biomass(:,:,60),1);
    
    fig=figure;
    set(fig,'defaultAxesColorOrder',[[65/255 105/255 225/255]; [0 0 0 ]]);
    yyaxis left;
    plot(1:length(cv_cycle),cv_cycle,'LineWidth',2)
    ylabel('CV of total biomass')
    set(gca,'Fontsize',16)
    
    yyaxis right;
    plot((1:length(nb_species))/365,nb_species,'-k','LineWidth',2)
    ylabel('Nb extant species')
    set(gca,'Ylim',[min(nb_species)-0.5 max(nb_species)+0.5],'Fontsize',16)
    
    title('Convergence criteria','Fontsize',18)
end