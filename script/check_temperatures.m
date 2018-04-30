%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Looking at temperatures

close all; clear all; clc;
dir_output='./output_simulation/white_noise/';
extension='_noforcedcompetition_10higherintra_weightedinteraction.mat';
tau_min=zeros(1,50);
tau_max=zeros(1,50);

hold on
for iter=1:50
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
    load(filename)
    tau_min(iter)=min(tau);
    tau_max(iter)=max(tau);
%   if(iter<50)
%    subplot(7,7,iter)
%     iter
%     switch iter
%         case 7
%             subplot(2,2,1)
%             plot(youtbis)
%             title(num2str(iter))
%         case 40
%             subplot(2,2,2)
%             plot(youtbis)
%             title(num2str(iter))
%         case 17
%             subplot(2,2,3)
%             plot(youtbis)
%             title(num2str(iter))
%         case 32
%             subplot(2,2,4)
%             plot(youtbis)
%             title(num2str(iter))
%     end
%    hist(tau) %Nothing here
%    title(iter)
%    end
%     hold on
     if(iter~=17&&iter~=32)
         plot(nb_species,'-k')
     else
         plot(nb_species,'-r','LineWidth',2)
     end
%Nothing here either...

end;
hold off


figure
hold on;
plot(tau_min)
plot([17 17], [265 270])
plot([32 32], [265 270])
hold off;

figure;
hold on;
plot(tau_max)
plot([17 17], [316 322])
plot([32 32], [316 322])
hold off;

%No explanation in min or max


%I also checked community-wide synchronys: did not find anything really
%different in iter=17 or 32.