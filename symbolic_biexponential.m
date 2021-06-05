syms a b J K L z

tau_a = 280e-9;
tau_b = 68e-9;
sampling_period = 1e-9;

flattop = 16;
risetime = 4;
falltime = 4;

fraction_precision = 4;


subvars = [a, b, J, K, L];
subvals = [exp(-sampling_period/tau_a), exp(-sampling_period/tau_b), risetime, flattop, falltime];
nominator = (z-a)*(z-b)*(z^L-z^(L-J)-z^(L-K)+1);
denominator = J*(a-b)*z^L;



subnom = vpa(expand(subs(nominator, subvars, subvals)), fraction_precision);
subdenom = vpa(expand(subs(denominator, subvars, subvals)), fraction_precision);

filter = vpa(expand(subnom/subdenom),fraction_precision)

nom_iir = zeros(1, 19);
nom_iir(1) = -22.66; nom_iir(2) = 44.91; nom_iir(3) = -22.25; 
nom_iir(17) = 22.66; nom_iir(18) = -44.91; nom_iir(19) = 22.25;

denom_iir = 1;
