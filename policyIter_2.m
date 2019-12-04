function policy = policyIter_2(v1,policy,PSS,target)
%stable = false;
gama = 0.9;
c = zeros(1,10);
q = zeros(10,10);

%while stable == false
    
    %b = policy;
    for s = 1:10
        for a = 1:10
            for sprime = 1:10
                r = -1*abs(sprime-target);
                c(sprime)= PSS(s,sprime,a)*(r+gama*v1(sprime));
            end
            q(s,a) = sum(c);
            c = zeros(1,10);
        end
        [argvalue, argmax]= max(q(s,:));
        policy(s) = argmax;
        
    end
    
    %if b == policy
      % stable = true;
    %else b ~= policy(s)
       %v1 = policyEva(PSS,policy);
       %policy = policyIter(v1,policy,PSS);
    %end
    
%end