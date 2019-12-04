function p = getP(S,D, sd)
fun = Gaussian(S,sd);
xmax = D+0.5;
xmin = D-0.5;
p = integral(fun,xmin,xmax);