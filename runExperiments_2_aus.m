function [Q,data,POLICY] = runExperiments_2_aus(ET_aus,Precipitation_aus,N)
data = zeros(N,5);
POLICY = zeros(N,20);
Q = zeros(21,4,N);

for i = 1: N
    
    [Q_tab,policy,S,A,R,WCL_3,WCL,Irrigation_3] = TestCode_aus(ET_aus,Precipitation_aus);
    [Irrigation_3,WCL_3,WCL,result] = run_policy_aus(policy,ET_aus,Precipitation_aus);
    data(i,:) = result;
    Q(:,:,i) = Q_tab;
    POLICY(i,:) = policy;
end