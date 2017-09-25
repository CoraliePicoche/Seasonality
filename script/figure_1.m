%%% Model of Scranton & Vasseur 2016 (Theor Ecol.)
%%% Developped by Picoche & Barraquand 2017
%%% fraction of the maximum growth rate achieved for one species

function f = figure_1(b,tau_opt)
global S

temp_min=12;
temp_max=26;
tmp_tot=linspace(temp_min,temp_max,1000)+273.15;
r=growth_response(tmp_tot);

figure;hold on;
%a
for i=1:S
    densr=365.25*r.*frac_max(tmp_tot,tau_opt(i),b(i));
    plot(tmp_tot-273.15,densr);
    plot(tmp_tot-273.15,365.25*r,'k');
end;
hold off;

%b
tau=normrnd(20+273.15,5,1,1000);
figure;hold on;
plot(tmp_tot-273.15,ones(1,length(tmp_tot))*15,'Color',[.17 .17 .17]);
ylim([0 100]);
for i=1:S
    gg=mean(365.25*growth_response(tau).*frac_max(tau,tau_opt(i),b(i)));
    plot(tau_opt(i)-273.15,gg,'+')
    plot([tau_opt(i)-273.15 tau_opt(i)-273.15],[0 gg],'-')
end;
hold off;

end