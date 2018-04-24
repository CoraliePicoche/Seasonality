%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% Script only to visualize the differences between different values of
%%% theta on the temperature signal

clear all; close all; clc;
global mu_tau sigma_tau
mu_tau=293;
sigma_tau=5;
t=1:400; %just a little more than a year, just to have an idea
tau0=compute_temperature_season(t,0);
tau05=compute_temperature_season(t,1/2);
tau1=compute_temperature_season(t,1);
tausq2=compute_temperature_season(t,sqrt(2));
tau13=compute_temperature_season(t,1.3);
subplot(1,2,2)
plot(t,tau0,'-k')
title('\theta=0')
subplot(2,2,2)
plot(t,tau05,'-r')
title('\theta = 1/2')
subplot(2,2,3)
plot(t,tau1,'-b')
title('\theta=1')
subplot(2,2,4)
hold on;
plot(t,tau13,'-b')
plot(t,tausq2,'-g','LineWidth',2)
legend('\theta=1.3','\theta = \surd 2')