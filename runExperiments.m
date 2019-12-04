function [Q,data,POLICY,WCL_EX_1,WCL_EX_2,A_EX_1,A_EX_2] = runExperiments(ET,Precipitation,N)
data = zeros(N,4);
POLICY = zeros(N,20);
Q = zeros(21,4,N);
A_EX_1 = zeros(29,N);
A_EX_2 = zeros(29,N);
WCL_EX_1 = zeros(84,N);
WCL_EX_2 = zeros(84,N);

for i = 1: N
    
    [Q_tab,policy,S,A,R,WCL_3,WCL,Irrigation,Irrigation_3,runoff,ET_simu] = TestCode(ET,Precipitation);
    POLICY(i,:) = policy;
    A_EX_1(:,i) = A;
    WCL_EX_1(:,i) = WCL;
    [Y_kg,W_mm,Y_d,W_d,Net, WCL,Irrigation,ET_simu,S,runoff,A] = getWaterTable_4(policy,ET,Precipitation);
    WCL_EX_2(:,i) = WCL;
    A_EX_2(:,i) = A;
    data(i,1) = Y_kg;
    data(i,2) = W_mm;
    data(i,3) = Y_d;
    data(i,4) = W_d;
    data(i,5) = Net;
    Q(:,:,i) = Q_tab;
    i;
    data(i,:);
end

    