%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Function for ODE integration

function dydt = SV16_ode_integration_no_GR_in_competition(t,y)

global A m S r thresh_min
%A interaction matrix
%m mortality
%S number of species

dydt=zeros(S,1);
comp=zeros(1,S);

mask=transpose(find(y>=thresh_min));

%Competition
comp=A(:,mask)*y(mask);
dydt(mask)=(r(mask,floor(t))-m-comp(mask)).*y(mask);
end
