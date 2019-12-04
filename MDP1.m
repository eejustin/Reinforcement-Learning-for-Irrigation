function policy = policyIter(v1,policy)
stable = false;
gama = 0.9;
c = zeros(1,10);
q = zeros(10,10);

while stable == false
for s = 1:10
    b = policy(s);
    for a = 1:10
        for sprime = 1:10
            c(sprime)= PSS(s,sprime,a)*((10-sprime)+gama*v1(sprime));
        end
        q(s,a) = sum(c);
        c = zeros(1,10);
    end
    [argvalue, argmax]= max(q(s,:));
    policy(s) = argmax;
    if b == policy(s)
        stable = true;
    else b ~= policy(s)
        v1 = policyEva(PSS);
       break;
    end
end
