%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Function for ODE integration


function dydt = SV16_ode_integration(t,y)


global A m S thresh_min tau b tau_opt r
%A interaction matrix
%m mortality
%S number of species

dydt=zeros(S,1);
comp=zeros(1,S);


mask=transpose(find(y>=thresh_min));

%%%%
% r=zeros(S,1);
% r(mask,:)=fun(tau(floor(t)),b(mask),tau_opt(mask));   
%%%%


%Competition
comp=1-A(:,mask)*y(mask);
dydt(mask)=(r(mask,floor(t)).*comp(mask)-m).*y(mask); 
end