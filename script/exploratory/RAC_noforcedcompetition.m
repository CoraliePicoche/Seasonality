%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Using myplot_RAC to compare communities with different simulations,
%%% with no forced competition


clear all; close all; clc;

load("output_simulation/no_forced_competition/iter2_codeversion_20180228_theta0_noforcedcompetition.mat")
comm_SV=mean(youtbis,1);
load("output_simulation/no_forced_competition/iter2_codeversion_20180228_theta0_noforcedcompetition_weightedinteraction.mat")
comm_weighted=mean(youtbis,1);
load("output_simulation/no_forced_competition/iter2_codeversion_20180228_theta0_noforcedcompetition_10higherintra.mat")
comm_10higherintra=mean(youtbis,1);
load("output_simulation/no_forced_competition/iter2_codeversion_20180228_theta0_noforcedcompetition_Ashbyformulation.mat")
comm_Ashby=mean(youtbis,1);

comm_all=[comm_SV;comm_weighted;comm_10higherintra;comm_Ashby];
myplot_RAC(comm_all,{''},{'Classif, no storage','Weighted by median GR','Higher intragroup 10','Ashby'},{},jet(60))