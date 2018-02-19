clear all; clc; close all;

yspan=200; %we want 200 years of simulations
ywindow=5;
thresh_min=10^(-6);
%alpha=0.001;

s1=14;
s2=43; %it will eventually be 1->60, keeping in mind the fact that SV only observe stuff for 14->43 
extant=3; %will be 2, 3 or more if it happens, but it should not according to first views

adir='./output_simulation/invasion/';
allfiles=dir(adir);
fileNames = {allfiles(~[allfiles.isdir]).name};
plou=zeros(1,length(fileNames));
mat=zeros(s2-s1+1,s2-s1+1);
mat_id=zeros(s2-s1+1,s2-s1+1);
c=jet(s2-s1+1);
for f=1:length(fileNames)
        fileNames(f)
        
    load(strcat([adir,fileNames{f}]));
    S=size(youtbis,2); %number of species
        mask=youtbis(end,:)>10^-6;
        plou(f)=sum(mask);
        if(sum(mask)>1)
            id=find(mask==1);
            id1=min(id);
            id2=max(id);
            if sum(mask)==3
                mat_col(id1-s1+1,id2-s1+1)=id(id>id1&id<id2)-s1+1;
            end;
            if sum(mask)==extant
                mat(id1-s1+1,id2-s1+1)=mat(id1-s1+1,id2-s1+1)+1;
            end;
        end
end
    
xx=tau_opt(s1:s2)-273;
yy=xx;

nb_diff=length(unique(mat));
if extant==2 %two species together, we use only grey
    min_grey=60; max_grey=200;
    grey_scale=linspace(max_grey,min_grey,nb_diff)/256;
end;

hold on;
plot(xx,yy,'-k');
for i=s1:s2
    x1=max(1,i-s1-1);
    x2=min(s2,i-s1+1);
    plot([xx(x1) xx(x2)],[yy(x1) yy(x2)],'-','color',c(i-s1+1,:))
end

for i=1:length(xx)
    for j=1:length(yy)
        if mat(i,j)>0 
            if extant==2 
                plot(xx(i),yy(j),'o','color',[grey_scale(mat(i,j)) grey_scale(mat(i,j)) grey_scale(mat(i,j))])
            else
                s=scatter(xx(i),yy(j),60,c(mat_col(i,j),:),'filled');
                alpha(s,(mat(i,j)-min(min(mat)))/(max(max(mat))-min(min(mat))))
            end
        end
    end
end
hold off;

