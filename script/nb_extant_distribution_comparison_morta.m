%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Boxplot for the not-so-stable cases

clear all; close all; clc;
thresh_min=10^(-6);

dir_output='./output_simulation/white_noise/';
%Filename for +SE-SND
extension='.mat';

nb_final_1=zeros(100,4);

for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    nb_final_1(iter,1)=sum(youtbis(end,:)>thresh_min);
    filename=strcat(dir_output,'morta_variable/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_final_1(iter,2)=sum(youtbis(end,:)>thresh_min);
end;

dir_output='./output_simulation/season/';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    nb_final_1(iter,3)=sum(youtbis(end,:)>thresh_min);
    filename=strcat(dir_output,'morta_variable/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_final_1(iter,4)=sum(youtbis(end,:)>thresh_min);
end;

subplot(2,1,1)
hold on;
for i=1:4
   if i<3
       col='blue';
   else
       col="red";
   end
   if mod(i,2)==1
       sty="-";
   else
       sty=":";
   end
   all_var=unique(nb_final_1(:,i));
   tmp=zeros(1,length(all_var));
   for a=1:length(all_var)
       tmp(a)=sum(nb_final_1(:,i)==all_var(a));
   end
   plot(all_var,cumsum(tmp),'Color',col,'LineStyle',sty,'Marker','.','MarkerSize',20)
end
hold off;

dir_output='./output_simulation/white_noise/';
extension='_noforcedcompetition_10higherintra_weightedinteraction.mat';
nb_final_2=zeros(100,4);

for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    nb_final_2(iter,1)=sum(youtbis(end,:)>thresh_min);
    filename=strcat(dir_output,'morta_variable/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_final_2(iter,2)=sum(youtbis(end,:)>thresh_min);
end;

dir_output='./output_simulation/season/';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
    load(filename)
    nb_final_2(iter,3)=sum(youtbis(end,:)>thresh_min);
    filename=strcat(dir_output,'morta_variable/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    nb_final_2(iter,4)=sum(youtbis(end,:)>thresh_min);
end;



subplot(2,1,2)
hold on;
for i=1:4
   if i<3
       col='blue';
   else
       col="red";
   end
   if mod(i,2)==1
       sty="-";
   else
       sty=":";
   end
   all_var=unique(nb_final_2(:,i));
   tmp=zeros(1,length(all_var));
   for a=1:length(all_var)
       tmp(a)=sum(nb_final_2(:,i)==all_var(a));
   end
   plot(all_var,cumsum(tmp),'Color',col,'LineStyle',sty,'Marker','.','MarkerSize',20)
end
hold off;
