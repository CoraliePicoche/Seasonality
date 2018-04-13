%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Using myplot_RAC to compare communities with different simulations


clear all; close all; clc;

load("output_simulation/SV_same_temp/iter2_codeversion_20180228_theta0.mat")
comm_SV=mean(youtbis,1);
load("output_simulation/SV_same_temp/iter2_codeversion_20180228_theta0_competitonintrahigherthanextra.mat")
comm_higherintra=mean(youtbis,1);
load("output_simulation/SV_same_temp/iter2_codeversion_20180228_theta0_competitonintrahigherthanextra_only4timeshigher.mat")
comm_4higherintra=mean(youtbis,1);
load("output_simulation/SV_same_temp/iter2_codeversion_20180228_theta0_Ashby_formulation.mat")
comm_Ashby=mean(youtbis,1);
load("output_simulation/season/1no_stochasticity.mat");
comm_seasononly=mean(youtbis,1);

comm_all=[comm_SV;comm_higherintra;comm_4higherintra;comm_Ashby;comm_seasononly];
myplot_RAC(comm_all,{''},{'Regular SV','Higher intragroup 10','Higher intragroup 4','Ashby','Season'},{},jet(60))