function post_PSS = get_post_PSS(DS,PSS,observation)
post_PSS = PSS;
update = zeros(1,10);
PDSA = zeros(10,10,10);
for a = 1:10
    for s = 1:10
        for d = 1:10    
            if (observation (s,d,a) > 0)
            for n = 1:observation (s,d,a)
                for i = 1:10
                update(i)=DS(d,i)*post_PSS(s,i,a);
                end
                PDSA(s,d,a) = sum(update);
                for sprime = 1:10
                post_PSS(s,sprime,a) = update(sprime)/PDSA(s,d,a);
                end
            end
            end
        end
    end
end




