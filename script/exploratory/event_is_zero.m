function [value,isterminal,direction] = event_is_zero(t,y)
global s_invasive
value = max(0,y(s_invasive)-10^(-6));     % detect height = 0
isterminal = 1;   % stop the integration
direction = 0;   % negative direction;