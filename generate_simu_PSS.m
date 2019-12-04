function  observation = getObservation(bias,sd,N)
observation = zeros(10,10,10);
for s = 1:10
    for s_prime = 1:10
        for a = 1:10
           observation(s,d,a)= N*getP(s+a-1+bias,d,sd);
        end
    end
end
