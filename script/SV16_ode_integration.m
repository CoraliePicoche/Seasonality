%%% Model first developped by of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Script by Picoche & Barraquand 2017
%%% Function for ODE integration


function dydt = SV16_ode_integration(t,y)


global A m S thresh_min tau b tau_opt r morta_vect
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
mask=transpose(find(y>=thresh_min)); %Only integrates for extant species

%Competition
comp=1-A(:,mask)*y(mask);
dydt(mask)=(r(mask,floor(t)).*comp(mask)-morta_vect(mask)).*y(mask); 
end