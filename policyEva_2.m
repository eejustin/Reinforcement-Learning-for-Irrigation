function v1 = policyEva_2(PSS,policy,target)

gama = 0.9;
v1 = zeros(1,10);
v2 = ones(1,10);
c = zeros(1,10);
delta = 0.001;
N = 0;

while sum(abs(v2-v1))> delta
   N = N+1;
   v2 = v1;
   for s = 1:10
       for sprime = 1:10
           r = -1*abs(sprime-target);
           c(sprime)= PSS(s,sprime,policy(s))*(r+gama*v1(sprime));
       end
       v1(s) = sum(c);
       c = zeros(1,10);
            
   end
end

fprintf('%d',N);


