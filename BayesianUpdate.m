function post_PSS = BayesianUpdate(PSS,observation)
post_PSS = PSS;
for a = 1:10
    for s = 1:10
        for d = 1:10    
            if (observation (s,d,a) > 0)
            for n = 1:observation (s,d,a)
                post_PSS(s,d,a) = post_PSS(s,d,a)+1;
                post_PSS(s,:,a) = post_PSS(s,:,a)/2;
            end
            end
        end
    end
end