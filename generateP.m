function P = generateP(sd)
P = zeros(6,6);

for s = 1:6 
    for sprime = 1:6
        xmax = sprime+0.5;
        xmin = sprime-0.5;
        fun = Gaussian(s,sd);
        p = integral(fun,xmin,xmax);
        P(s,sprime) = p;
        
    end
    P(s,1)= integral(Gaussian(s-1,sd),log(0),0.5);
    P(s,6)= integral(Gaussian(s,sd),5.5,exp(1000));
end


