function [Irrigation_3,WCL_3,WCL,result] = run_policy_cad(policy,ET_cad,Precipitation_cad)
corn_price = 0.2;
water_price =1;

WCL_3 = zeros(34,1);
WCL_3(1) = 359;
WCL = zeros(102,1);
WCL(1) = 359;
Irrigation_3  = zeros(34,1);

S = zeros(34,1);
A = zeros(34,1);

    for i = 1:5
        S(i) = getState_cad(i,WCL_3(i));
        A(i) = 1;
        [Irrigation_3,WCL_3,WCL] = Irri_WCL_Predict_cad(WCL,A(i),Precipitation_cad,ET_cad,Irrigation_3,WCL_3,i);
    end
    
    for i = 6:34
        S(i) = getState_cad(i,WCL_3(i));
        A(i) = policy(S(i));        
        [Irrigation_3,WCL_3,WCL] = Irri_WCL_Predict_cad(WCL,A(i),Precipitation_cad,ET_cad,Irrigation_3,WCL_3,i);
    end
    
    Y_kg = Predict_yield_cad(WCL);
    W_mm = -sum(Irrigation_3);
    Y_d = Y_kg*corn_price;
    W_d = W_mm*water_price;
    Net = Y_d + W_d;
    
    result = [Y_kg,W_mm,Y_d,W_d,Net];