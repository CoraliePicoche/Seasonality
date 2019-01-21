%%%essai
function f = fun(x,b,tau_opt)
%%%%
f= growth_response(x).*frac_max_vectoriel(x,tau_opt,b);
%%%%
end