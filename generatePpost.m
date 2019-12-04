function Ppost = generatePpost(delta,sd)
Ppost = zeros(6,6);

for s = 1:6 
    for sprime = 1:6
        xmax = sprime+0.5;
        xmin = sprime-0.5;
        fun = Gaussian(s+delta,sd);
        p = integral(fun,xmin,xmax);
        Ppost(s,sprime) = p;
        
    end
    Ppost(s,1)= integral(Gaussian(s-1+delta,sd),log(0),0.5);
    Ppost(s,6)= integral(Gaussian(s+delta,sd),5.5,exp(1000));
end