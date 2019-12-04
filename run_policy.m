function [Irrigation_3,WCL_3,WCL,result] = run_policy(policy,ET,Precipitation)
corn_price = 0.2;
water_price =1;
WCL_3 = zeros(28,1);
WCL_3(1) = 540;
WCL = zeros(84,1);
WCL(1) = 540;
Irrigation_3  = zeros(28,1);
S = zeros(28,1);
A = zeros(28,1);

    
    for i = 1:28
        S(i) = getState_4(i,WCL_3(i));
        A(i) = policy(S(i));        
        [Irrigation_3,WCL_3,WCL] = Irri_WCL_Predict(WCL,A(i),Precipitation,ET,Irrigation_3,WCL_3,i);
    end
    
    Y_kg = myNeuralNetworkFunction(WCL);
    W_mm = -sum(Irrigation_3);
    Y_d = Y_kg*corn_price;
    W_d = W_mm*water_price;
    Net = Y_d + W_d;
    
    result = [Y_kg,W_mm,Y_d,W_d,Net];
