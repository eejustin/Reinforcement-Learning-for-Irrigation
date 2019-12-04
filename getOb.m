function [post_PSS,obs,Statistics] = getOb(P,delta,sd,size)
ob = zeros(6);
obs = zeros(6,size);
Statistics = zeros(6);
post_PSS = P; 

for s = 1:6
    for sprime = 1:5
        xmax = sprime+0.5;
        xmin = log(0);
        fun = Gaussian(s+delta,sd);
        p = integral(fun,xmin,xmax);
        ob(s,sprime) = p;        
    end
    ob(s,6)= 1;
end



for s = 1:6
    for N = 1:size
        x = rand;
        if x <= ob(s,1)
           obs(s,N) = 1;
           Statistics(s,1) = Statistics(s,1)+1;
        elseif x <= ob(s,2)
           obs(s,N) = 2;
           Statistics(s,2) = Statistics(s,2)+1;
        elseif x <= ob(s,3)
           obs(s,N) = 3;
           Statistics(s,3) = Statistics(s,3)+1;
        elseif x <= ob(s,4)
           obs(s,N) = 4;   
           Statistics(s,4) = Statistics(s,4)+1;
        elseif x <= ob(s,5)
           obs(s,N) = 5;
           Statistics(s,5) = Statistics(s,5)+1;
        else
           obs(s,N) = 6;   
           Statistics(s,6) = Statistics(s,6)+1;
        end       
    end 
end



for s = 1:6
    for N = 1:size        
        post_PSS(s,obs(s,N)) = post_PSS(s,obs(s,N))+1;
    end
    post_PSS(s,:) = post_PSS(s,:)/sum(post_PSS(s,:));
end
