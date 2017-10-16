clear all; close all; clc;

thresh_min=10^(-6);
S=60;

adir='./output_simulation/SV_same_temp/';
allfiles=dir(adir);
fileNames = {allfiles(~[allfiles.isdir]).name};
f=5;
load(strcat([adir,fileNames{f}]));
mask=youtbis(end,:)<thresh_min;
sbis=1:S;
sbis=sbis(~mask); 

load(strcat('./output_simulation/KO/simu',num2str(f),'_null_model.mat')) %,'tout_null_bis','yout_null_bis','tau_opt','b','tau');

mat_results=zeros(length(sbis),length(sbis));
for s=sbis
    load(strcat('./output_simulation/KO/simu',num2str(f),'_KO_',num2str(s),'.mat')) %,'y_2_bis');
    
    for s2=sbis
        mat_results(s-sbis(1)+1,s2-sbis(1)+1)=y_2_bis(end,s2)-yout_null_bis(end,s2);        
    end
end;
correlationCircles(mat_results);
