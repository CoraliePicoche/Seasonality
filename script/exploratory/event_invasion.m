function [value,isterminal,direction] = event_invasion(t,y)
global invasion_time
value = 1.0*(ismember(floor(t(1)),invasion_time)-1);     % detect height = 0
if value==0
    print t
end;
isterminal = 1;   % stop the integration
direction = 0;   % negative direction;
