function post_PSS = BayesianUpdate_2(P, observation)
post_PSS = P;
for s = 1:6
    for d = 1:6
        if observation(s,d)>0
            for n = 1:observation (s,d)
                post_PSS(s,d) = post_PSS(s,d)+1;
                post_PSS(s,:) = post_PSS(s,:)/2;
            end
        end
    end
end

            