function [Irrigation_3,WCL_3,WCL,result] = run_policy_aus(policy,ET_aus,Precipitation_aus)
corn_price = 0.2;
water_price =1;

    WCL_3 = zeros(31,1);
    WCL_3(1) = 540;
    WCL = zeros(93,1);
    WCL(1) = 540;
    Irrigation_3  = zeros(30,1);

    S = zeros(31,1);
    A = zeros(31,1);


    
    for i = 1:31
        S(i) = getState_aus(i,WCL_3(i));
        A(i) = policy(S(i));        
        [Irrigation_3,WCL_3,WCL] = Irri_WCL_Predict_aus(WCL,A(i),Precipitation_aus,ET_aus,Irrigation_3,WCL_3,i);
    end
    
    Y_kg = Predict_yield_aus(WCL);
    W_mm = -sum(Irrigation_3);
    Y_d = Y_kg*corn_price;
    W_d = W_mm*water_price;
    Net = Y_d + W_d;
    
    result = [Y_kg,W_mm,Y_d,W_d,Net];
