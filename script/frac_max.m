%%% Model first developped by of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Script by Picoche & Barraquand 2017
%%% This function computes the fraction of the maximum growth rate achieved
%%% for one  for the whole temperature time series

function f = frac_max(tau,tau_opt,b)

for t=1:length(tau)
    if b<0
        f(t)=10^9; %just a small trick to avoid the Infinite when searching for the right b
    else
        tmp=-abs(tau(t)-tau_opt)^3/b;
        if tau(t)>tau_opt
            tmp=tmp*5;
        end;
       f(t)=exp(tmp);
    end;
end;

end