%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2018
%%% Function to compute species-specific synchronies
%%% This index was developped by SV


function res=species_specific_synchrony(youtbis, varargin)
    S=size(youtbis,2); %number of species
    tt=size(youtbis,1);
    optargs={200 5 0.001*ones(S)}; %corresponidng to default value for ywindow, yspan and alpha, respectively
    thresh_min=10^(-6);
    
    num_argin=length(varargin);
    optargs(1:num_argin)=varargin;
    yspan=optargs{1};
    ywindow=optargs{2};
    A_comm_matrix=optargs{3};
    
   if size(A_comm_matrix)~=size(ones(S))
            error('The community matrix input does not correspond to the simulate community')
   end
   
   if yspan>tt/365
       error('Size of the window is larger than the simulation')
   end
   
   ymax=floor(tt/365)-ceil(ywindow/2); %année max-3 to be able to compute the average
   ymin=ymax-yspan+1; %we want 200 years of simulations
    
   synchrony=zeros(yspan,S);
   mask=youtbis(end,:)<thresh_min;
   sbis=1:S;
   sbis=sbis(~mask); %extant species
    for t=ymin:ymax
        t1=floor((t-ywindow/2)*365+1);
        t2=ceil((t+ywindow/2)*365+1);
        y=youtbis(t1:t2,:);
        for s1=sbis
            for s2=sbis
                if s1~=s2
                    a=corrcoef(y(:,s1),y(:,s2));
                    synchrony(t-ymin+1,s1)=synchrony(t-ymin+1,s1)+A_comm_matrix(s1,s2)*std(y(:,s2))*a(1,2);
                    synchrony(1,~mask);
                end
            end;
        end;
    end;
    res=synchrony;
end