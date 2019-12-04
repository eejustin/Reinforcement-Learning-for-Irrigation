function [Q,data,POLICY] = runExperiments_2_ind(ET_ind,Precipitation_ind,N)
data = zeros(N,5);
POLICY = zeros(N,15);
Q = zeros(16,4,N);

for i = 1: N
    
    [Q_tab,policy,S,A,R,WCL_3,WCL,Irrigation_3] = TestCode_ind(ET_ind,Precipitation_ind);
    [Irrigation_3,WCL_3,WCL,result] = run_policy_ind(policy,ET_ind,Precipitation_ind);
    data(i,:) = result;
    Q(:,:,i) = Q_tab;
    POLICY(i,:) = policy;
end