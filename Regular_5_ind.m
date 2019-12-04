function [result,WCL,Irrigation] = Regular_5_ind(ET_ind,Precipitation_ind,t,d)
corn_price = 0.2;
water_price =1;
WCL = zeros(74,1);
WCL(1) = 540;
Irrigation  = zeros(74,1);

for j = 1:73

        if mod(j,t) == 1
            Irrigation(j) = d;
        end

        Var_x2 = [WCL(j),Precipitation_ind(j),ET_ind(j),Irrigation(j)];
        WCL(j+1) = Predict_WCL_ind(Var_x2);
end

    Y_kg = Predict_yield_ind(WCL);
    W_mm = -sum(Irrigation);
    Y_d = Y_kg*corn_price;
    W_d = W_mm*water_price;
    Net = Y_d + W_d;
    
    result = [Y_kg,W_mm,Y_d,W_d,Net];