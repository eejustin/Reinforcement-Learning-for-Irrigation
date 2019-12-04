function PSS = generatePSS(sd)
PSS = zeros(10,10,10);
for s = 1:10
    for s_prime = 1:10
        for a = 1:10
           PSS(s,s_prime,a)= getP(s+a-1,s_prime,sd);
        end
    end
end
