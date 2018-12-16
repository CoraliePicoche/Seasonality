%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Function for ODE integration


function dydt = SV16_ode_integration(t,y)


global A m S thresh_min tau b tau_opt r morta_vect
%A interaction matrix
%m mortality
%morta_vect with the variable mortality that Barabas asked for
%S number of species

dydt=zeros(S,1);
comp=zeros(1,S);


mask=transpose(find(y>=thresh_min));

%%%%
% r=zeros(S,1);
% r(mask,:)=fun(tau(floor(t)),b(mask),tau_opt(mask));   
%%%%

%if(length(mask)<1) 
%    'Everbody died'
%end

if(floor(t)>size(r,2))
    'WTF ?'
end

%Competition
comp=1-A(:,mask)*y(mask);
%dydt(mask)=(r(mask,floor(t)).*comp(mask)-m).*y(mask); 
dydt(mask)=(r(mask,floor(t)).*comp(mask)-morta_vect(mask)).*y(mask); 
end