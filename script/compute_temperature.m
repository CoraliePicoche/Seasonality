%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Function for temperature

function [tau] = compute_temperature(t)
global mu_tau sigma_tau
%for now, we're just using a random value, that's option 1

tau=normrnd(mu_tau,sigma_tau,1,length(t));

end