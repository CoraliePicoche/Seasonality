%%% Model first developped by of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Script by Picoche & Barraquand 2017
%%% This function computes the growth response to temperature

function growth = growth_response(tau)
global a_r_tau0 tau0 E_r k 

growth=a_r_tau0*exp(E_r*(tau-tau0)./(k*tau*tau0));
end