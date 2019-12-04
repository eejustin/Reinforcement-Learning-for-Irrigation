function v1 = policyEva(PSS,policy)

gama = 0.9;
v1 = zeros(1,10);
v2 = ones(1,10);
c = zeros(1,10);
delta = 0.01;
N = 1;

while sum(abs(v2-v1))> delta
   N = N+1;
   v2 = v1;
   for s = 1:10
       for sprime = 1:10
           c(sprime)= PSS(s,sprime,policy(s))*(sprime+gama*v1(sprime));
       end
       v1(s) = sum(c);
       c = zeros(1,10);
            
   end
end

fprintf('%d',N);


