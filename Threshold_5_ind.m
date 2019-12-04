function [result,WCL,Irrigation_3] = Threshold_5_ind(ET,Precipitation,t,d)
corn_price = 0.2;
water_price =1;

    WCL_3 = zeros(25,1);
    WCL_3(1) = 540;
    WCL = zeros(74,1);
    WCL(1) = 540;
    Irrigation_3  = zeros(25,1);

for i = 1:25
        if WCL_3(i) < t
            Irrigation_3(i) = d;
        end
        
        j = (i-1)*3+1;

        Var_x2 = [WCL(j),Precipitation(j),ET(j),Irrigation_3(i)];
        WCL(j+1) = Predict_WCL_ind(Var_x2);
        

       if i < 25
            Var_x3 = [WCL(j+1),Precipitation(j+1),ET(j+1),0];
            WCL(j+2) = Predict_WCL_ind(Var_x3);


            Var_x4 = [WCL(j+2),Precipitation(j+2),ET(j+2),0];
            WCL(j+3) = Predict_WCL_ind(Var_x4);
            WCL_3(i+1) = WCL(j+3);
       end 
end

    Y_kg = Predict_yield_ind(WCL);
    W_mm = -sum(Irrigation_3);
    Y_d = Y_kg*corn_price;
    W_d = W_mm*water_price;
    Net = Y_d + W_d;
    
    result = [Y_kg,W_mm,Y_d,W_d,Net];