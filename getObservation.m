function  [observation,distribution] = getObservation(bias,sd,N)
distribution = zeros(10,10,10);
for s = 1:10
    for d = 1:10
        for a = 1:10
           distribution(s,d,a)= getP(s+a-1+bias,d,sd);
        end
    end
end
observation = round(N*distribution);