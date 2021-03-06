clear all; clc; close all;

yspan=200; %we want 200 years of simulations
ywindow=5;
thresh_min=10^(-6);
alpha=0.001;

adir='./output_simulation/season/';

c=jet(60);

a_median=zeros(1,10);
    for f=1:10
        filename=strcat([adir,'iter',num2str(f),'_codeversion_20180228_theta1p3_competitonintrahigherthanextra_10higher.mat'])
%        if(size(regexp(fileNames{f},'codeversion_20180228_theta1p3.mat'))>0)
    load(filename);
    S=size(youtbis,2); %number of species
    ymax=floor(toutbis(end,1)/365)-ceil(ywindow/2)-toutbis(1,1)/365; %année max-3 to be able to compute the average
    ymin=ymax-yspan+1; %we want 200 years of simulations
    
%     synchrony=zeros(yspan,S);
     mask=youtbis(end,:)<thresh_min;
     sbis=1:S;
     sbis=sbis(~mask); %extant species
%     c=jet(length(sbis));
     a_median(f)=length(sbis);
%     fileNames{f}
%     length(sbis)
%     for t=ymin:ymax
%         t1=floor((t-ywindow/2)*365+1);
%         t2=ceil((t+ywindow/2)*365+1);
%         y=youtbis(t1:t2,:);
%         for s1=sbis
%             for s2=sbis
%                 if s1~=s2
%                     a=corrcoef(y(:,s1),y(:,s2));
%                     synchrony(t-ymin+1,s1)=synchrony(t-ymin+1,s1)+alpha*std(y(:,s2))*a(1,2);
%                     synchrony(1,~mask);
%                 end
%             end;
%         end;
% %         if synchrony(t-ymin+1,s1)>0
% %             t
% %             s1
% %         end
%     end;
% sp=0;
% figure; hold on;
% for s1=sbis
%     sp=sp+1;
%     plot(1:yspan,synchrony(:,s1),'color',c(sp,:));
% end
%        
% hold off;

sp=0;
figure; hold on;
for s1=sbis
    sp=sp+1;
    ymean=mean(youtbis(floor(ymin*365):floor(ymax*365),s1));
   bar(tau_opt(s1)-273,ymean,0.1,'FaceColor',c(s1,:));
 %  set(gca,'yscale','log')
%title('Mean biomass')
%   ylim([150 350])
end;
%title('Mean biomass')
   title(strcat([num2str(f)]))

hold off;
 %       end;
end