%%% Developped by Picoche & Barraquand 2018
%%% Compare different community-wide synchrony index (Loreau and Gross, by
%%% year for the last 500 years saved at the end of a simulation)

function [tab_indices] = community_wide_indices(filename)
thresh_min=10^(-6);
%filename='output_simulation/SV_same_temp/iter1_codeversion_20180228_theta0.mat';
load(filename)
%youtbis=youtbis(2:end,:); small trick when looking at old files in
%SV_different_temp
youtbis(youtbis<thresh_min)=0;
if(mod(size(youtbis,1),365)~=0)
    youtbis=youtbis(1+mod(size(youtbis,1),365):end,:);
end;
nb_year=size(youtbis,1)/365;
S=size(youtbis,2);

%%Loreau & Mazancourt (2008)
biomass_over_year=reshape(youtbis,365,nb_year,S); % x = julian day ; y = year ; z species

community_cycle=cumsum(biomass_over_year,3); %total biomass over a cycle
community_cycle=reshape(community_cycle(:,:,60),365,nb_year); %x julian day; y year
community_sd=std(community_cycle,1);

pop_sd=std(biomass_over_year,1);
pop_sd=reshape(pop_sd(1,:,:),nb_year,S);

loreau_index=zeros(1,nb_year);
for y=1:nb_year
    loreau_index(y)=(community_sd(y))^2/(sum(pop_sd(y,:)))^2;
end;

%%Gross et al. (2014)
%Using Pearson correlation, as in codyn package
gross_index=zeros(1,nb_year);
for y=1:nb_year
    for s=1:S
        sbis=1:S;
        sbis=sbis(sbis~=s);
        sum_pop=sum(biomass_over_year(:,y,sbis),3);
        if(std(sum_pop)~=0&std(biomass_over_year(:,y,s))~=0)
            gross_index(y)=gross_index(y)+corr(biomass_over_year(:,y,s),sum_pop);
        end
    end;
    gross_index(y)=gross_index(y)/S;
end

tab_indices=vertcat(loreau_index,gross_index);

