%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Using myplot_RAC to compare communities with different simulations


clear all; close all; clc;

load("output_simulation/SV_same_temp/iter2_codeversion_20180228_theta0.mat")
comm_SV=mean(youtbis,1);
load("output_simulation/SV_same_temp/iter2_codeversion_20180228_theta0_competitonintrahigherthanextra.mat")
comm_higherintra=mean(youtbis,1);
load("output_simulation/season/1no_stochasticity.mat");
comm_seasononly=mean(youtbis,1);

comm_all=[comm_SV;comm_higherintra;comm_seasononly];
myplot_RAC(comm_all,{''},{'Regular SV','Higher intragroup comp','Season'},{},jet(60))
