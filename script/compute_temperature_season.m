%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Function for temperature

function [tau] = compute_temperature_season(t)
global mu_tau sigma_tau
%y1noise<-arima.sim(model=list(ar=c(0.1, 0.2, 0.1,0.5,-0.1)), n=tmax,sd=sqrt(0.5) )
%mdl=arima('AR',{0.1, 0.2, 0.1,0.5,-0.},'Variance',sqrt(0.5))

%tau=normrnd(mu_tau,sigma_tau,1,length(t));


%Seasonality
tau=mu_tau+sigma_tau/2*sin(2*pi*t/365.25)+normrnd(0,sigma_tau/sqrt(2),1,length(t));

end