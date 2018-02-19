%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Function for temperature

function [tau] = compute_temperature_season(t)
global mu_tau sigma_tau amp_tau
%for now, we're just using a random value, that's option 1
%y1noise<-arima.sim(model=list(ar=c(0.1, 0.2, 0.1,0.5,-0.1)), n=tmax,sd=sqrt(0.5) )
%mdl=arima('AR',{0.1, 0.2, 0.1,0.5,-0.},'Variance',sqrt(0.5))

%tau=normrnd(mu_tau,sigma_tau,1,length(t));


%Seasonality
tau=mu_tau-amp_tau/2*cos(2*pi*t/365)+normrnd(0,sigma_tau,1,length(t));

end