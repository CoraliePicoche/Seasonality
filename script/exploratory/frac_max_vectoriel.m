%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% fraction of the maximum growth rate achieved for one species

function f = frac_max_vectoriel(tau,tau_opt,b)

for t=1:length(tau)
    if b<0
        f(t,1:length(b))=10^9; %just a small trick to avoid the Infinite when searching for the right b
    else
        tmp=-abs(tau(t)-tau_opt).^3./b;
        tmp(tau(t)>tau_opt)=tmp(tau(t)>tau_opt)*5;
       f(t,:)=exp(tmp);
    end;
end;

end