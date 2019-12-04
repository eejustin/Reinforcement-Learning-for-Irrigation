function [Irrigation_3,WCL_3,WCL,result] = run_policy_ind(policy,ET_ind,Precipitation_ind)
corn_price = 0.2;
water_price =1;

    WCL_3 = zeros(25,1);
    WCL_3(1) = 540;
    WCL = zeros(74,1);
    WCL(1) = 540;
    Irrigation_3  = zeros(25,1);

    S = zeros(25,1);
    A = zeros(25,1);


    
    for i = 1:25
        S(i) = getState_ind(i,WCL_3(i));
        A(i) = policy(S(i));        
        [Irrigation_3,WCL_3,WCL] = Irri_WCL_Predict_ind(WCL,A(i),Precipitation_ind,ET_ind,Irrigation_3,WCL_3,i);
    end
    
    Y_kg = Predict_yield_ind(WCL);
    W_mm = -sum(Irrigation_3);
    Y_d = Y_kg*corn_price;
    W_d = W_mm*water_price;
    Net = Y_d + W_d;
    
    result = [Y_kg,W_mm,Y_d,W_d,Net];