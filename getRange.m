function ob = getOb(delta,sd)

for s = 1:6 
    for sprime = 1:5
        xmax = sprime+0.5;
        xmin = log(0);
        fun = Gaussian(s+delta,sd);
        p = integral(fun,xmin,xmax);
        Ppost(s,sprime) = p;        
    end
    Ppost(s,6)= 1 - integral(Gaussian(s+delta,sd),log(0),5.5);
end