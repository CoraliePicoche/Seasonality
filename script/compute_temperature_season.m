%%% Model first developped by of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Script by Picoche & Barraquand 2017
%%% This function computes a random temperature time series with a seasonal
%%% signal, whose dominance depends on the value of theta

function [tau] = compute_temperature_season(t, theta)
global mu_tau sigma_tau

%Seasonality
tau=mu_tau+theta*sigma_tau*sin(2*pi*t/365)+normrnd(0,sigma_tau*sqrt(1-(theta^2)/2),1,length(t));

end