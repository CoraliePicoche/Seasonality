clear all; clc; close all;

yspan=200; %we want 200 years of simulations
ywindow=5;
thresh_min=10^(-6);
alpha=0.001;

adir='./output_simulation/invasion/';
allfiles=dir(adir);
fileNames = {allfiles(~[allfiles.isdir]).name};

    for f=1:length(fileNames)
        fileNames(f)
        
    load(strcat([adir,fileNames{f}]));
    S=size(youtbis,2); %number of species
        mask=youtbis(end,:)>10^-6;
        if sum(mask)>1
            mask
        end
    end