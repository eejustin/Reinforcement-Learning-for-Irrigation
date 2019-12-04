function [Q,data,POLICY] = runExperiments_2_cad(ET_cad,Precipitation_cad,N)
data = zeros(N,5);
POLICY = zeros(N,20);
Q = zeros(21,4,N);

for i = 1: N
    
    [Q_tab,policy,S,A,R,WCL_3,WCL,Irrigation_3] = TestCode_cad(ET_cad,Precipitation_cad);
    [Irrigation_3,WCL_3,WCL,result] = run_policy_cad(policy,ET_cad,Precipitation_cad);
    data(i,:) = result;
    Q(:,:,i) = Q_tab;
    POLICY(i,:) = policy;
end