%%% Model first developped by of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Script by Picoche & Barraquand 2017
%%% Function for ODE integration, removing the storage effect

function dydt = SV16_ode_integration_no_GR_in_competition(t,y)

global A m S r thresh_min morta_vect
%A interaction matrix
%m mortality
%S number of species
%thresh_min biomass below which a species is considered extinct
%tau temperature
%b and tau_opt species-specific parameters defining the thermal niche
%r growth rates depending on the temperature
%morta_vect with the variable mortality that Barabas asked for


dydt=zeros(S,1);
comp=zeros(1,S);

mask=transpose(find(y>=thresh_min));

%Competition
comp=A(:,mask)*y(mask);
dydt(mask)=(r(mask,floor(t))-morta_vect(mask)-comp(mask)).*y(mask);
end
