%%% Ugly plot, just to have all iterations in front of me
clear all; close all; clc;
thresh_min=10^(-6);
yspan=200;
afontsize=13;
col=jet(60);

dir_output='./output_simulation/white_noise/morta_variable';
%Filename for +SE-SND
extension='.mat';

biomass_final_1=zeros(60,100,2);

for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_1(:,iter,1)=mean_value;
end;

dir_output='./output_simulation/season/morta_variable';
for iter=1:100
    filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228',extension);
    load(filename)
    mean_value=species_mean_value(youtbis, yspan);
    biomass_final_1(:,iter,2)=mean_value;
end;

figure
for iter=1:49
    subplot(7,7,iter)
    hold on
plot(tau_opt-273,biomass_final_1(:,iter,1),'-o','MarkerFaceColor','b')
plot(tau_opt-273,biomass_final_1(:,iter,2),'-o','MarkerFaceColor','r')
% for xx=15:25
% plot([xx+.5 xx+.5],get(gca,'Ylim'),'--k')
% end
title(num2str(iter))
hold off
end
fig = gcf;
set(fig,'Position',[680 558 1500 1000])
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./article/Response_THE_2/graphe/DetailSE_1','-depsc')

figure
ii=1
for iter=50:98
subplot(7,7,ii)
ii=ii+1;
    hold on
plot(tau_opt-273,biomass_final_1(:,iter,1),'-o','MarkerFaceColor','b')
plot(tau_opt-273,biomass_final_1(:,iter,2),'-o','MarkerFaceColor','r')
% for xx=15:25
% plot([xx+.5 xx+.5],get(gca,'Ylim'),'--k')
% end
title(num2str(iter))
hold off
end
fig = gcf;
set(fig,'Position',[680 558 1500 1000])
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./article/Response_THE_2/graphe/DetailSE_2','-depsc')

iter=99
figure
subplot(1,2,1)

hold on
plot(tau_opt-273,biomass_final_1(:,iter,1),'-o','MarkerFaceColor','b')
plot(tau_opt-273,biomass_final_1(:,iter,2),'-o','MarkerFaceColor','r')
% for xx=15:25
% plot([xx+.5 xx+.5],get(gca,'Ylim'),'--k')
% end
title(num2str(iter))
hold off


iter=100
subplot(1,2,2)

hold on
plot(tau_opt-273,biomass_final_1(:,iter,1),'-o','MarkerFaceColor','b')
plot(tau_opt-273,biomass_final_1(:,iter,2),'-o','MarkerFaceColor','r')
% for xx=15:25
% plot([xx+.5 xx+.5],get(gca,'Ylim'),'--k')
% end
title(num2str(iter))
hold off
fig = gcf;
set(fig,'Position',[680 558 520 420])
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'./article/Response_THE_2/graphe/DetailSE_3','-depsc')

% extension='_noforcedcompetition_10higherintra_weightedinteraction.mat';
% 
% biomass_final_2=zeros(60,50,2);
% dir_output='./output_simulation/white_noise/';
% for iter=1:50
%     filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta0',extension);
%     load(filename)
%     mean_value=species_mean_value(youtbis, yspan);
%     biomass_final_2(:,iter,1)=mean_value;
% end;
% 
% dir_output='./output_simulation/season';
% for iter=1:50
%     filename=strcat(dir_output,'/iter',num2str(iter),'_codeversion_20180228_theta1p3',extension);
%     load(filename)
%     mean_value=species_mean_value(youtbis, yspan);
%     biomass_final_2(:,iter,2)=mean_value;
% end;
% figure
% seqe=2:6:50
% i=0;
% for iter=seqe
%     i=i+1;
%     subplot(3,3,i)
%     hold on
% plot(tau_opt-273,biomass_final_2(:,iter,1),'-o','MarkerFaceColor','b')
% plot(tau_opt-273,biomass_final_2(:,iter,2),'-o','MarkerFaceColor','r') 
% if(i==4)
%     ylabel('Biomass')
% end
% if(i==8)
%     xlabel('Thermal optimum')
% end;
% %plot([20 20],[0 50],'-k') %corresponds to the mean value of tau
% %plot([tau_opt(33)-273 tau_opt(33)-273],[0 50],'--k') %corresponds to the max of the mean values of r
% %title(num2str(iter))
% set(gca,'Fontsize',10)
% hold off
% end

% 
% fig = gcf;
% set(fig,'Position',[680 558 520 420])
% fig.PaperPositionMode = 'auto'
% fig_pos = fig.PaperPosition;
% fig.PaperSize = [fig_pos(3) fig_pos(4)];
% print(fig,'./article/graphe/all_iteration_from_morta_variable','-depsc')

% figure
% subplot(1,1,1)
% iter=50;
% hold on
% plot(tau_opt-273,biomass_final_2(:,iter,1),'-o','MarkerFaceColor','b')
% plot(tau_opt-273,biomass_final_2(:,iter,2),'-o','MarkerFaceColor','r')
% title(num2str(iter))
% plot([20 20],[0 50],'-k')
% plot([tau_opt(33)-273 tau_opt(33)-273],[0 50],'--k')
% hold off
