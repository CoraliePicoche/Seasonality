clear all; close all; clc;

thresh_min=10^(-6);
S=60;

adir='./output_simulation/SV_same_temp/';
allfiles=dir(adir);
fileNames = {allfiles(~[allfiles.isdir]).name};
f=7;
load(strcat([adir,fileNames{f}]));
mask=youtbis(end,:)<thresh_min;
sbis=1:S;
sbis=sbis(~mask); 

load(strcat('./output_simulation/KO/simu',num2str(f),'_null_model.mat')) %,'tout_null_bis','yout_null_bis','tau_opt','b','tau');

mat_results=zeros(length(sbis),length(sbis));
for s=sbis(2:end)
    load(strcat('./output_simulation/KO/simu',num2str(f),'_KO_',num2str(s),'.mat')) %,'y_2_bis');
    
    for s2=sbis(2:end)
        mat_results(s-sbis(1)+1,s2-sbis(1)+1)=y_2_bis(end,s2)-yout_null_bis(end,s2);        
    end
end;
%correlationCircles(mat_results);

xx=tau_opt(sbis(1):sbis(end))-273;
yy=xx;

hold on;
plot(xx,xx,'-k');
set(gca,'ydir','reverse')
for i=sbis
    for j=sbis
    if mat_results(i-sbis(1)+1,j-sbis(1)+1)<0
        col=[200 200 200]/256;
    elsexx=tau_opt(sbis(1):sbis(end))-273;
yy=xx;

hold on;
plot(xx,xx,'-k');
set(gca,'ydir','reverse')
for i=sbis
    for j=sbis
    if mat_results(i-sbis(1)+1,j-sbis(1)+1)<0
        col=[200 200 200]/256;
    else
        col=[0 0 0];
    end
    if abs(mat_results(i-sbis(1)+1,j-sbis(1)+1))>0
        scatter(xx(i-sbis(1)+1),yy(j-sbis(1)+1),10+30*round(log10(1+abs(mat_results(i-sbis(1)+1,j-sbis(1)+1)))),col,'filled')
    end
    end
    end
hold off;
        col=[0 0 0];
    end
    if abs(mat_results(i-sbis(1)+1,j-sbis(1)+1))>0
        scatter(xx(i-sbis(1)+1),yy(j-sbis(1)+1),10+30*round(log10(1+abs(mat_results(i-sbis(1)+1,j-sbis(1)+1)))),col,'filled')
    end
    end
    end
hold off;