%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Function for ODE integration

function dydt = SV16_ode_integration(t,y)

global A m S r thresh_min
%A interaction matrix
%m mortality
%S number of species
    
dydt=zeros(S,1);
comp=zeros(1,S);


for i=1:S
        if y(i)<thresh_min
        dydt(i)=0.0;
        else
        %Competition
        for j=1:S
                comp(i)=comp(i)+A(i,j)*y(j);
        end;
        comp(i)=1-comp(i);
        %Final
        dydt(i)=(r(i,floor(t))*comp(i)-m)*y(i);
    end;

end;
end