function [result,WCL,Irrigation] = Regular_5_cad(ET_cad,Precipitation_cad,t,d)
corn_price = 0.2;
water_price =1;
WCL = zeros(102,1);
WCL(1) = 359;
Irrigation  = zeros(102,1);

for j = 1:101

        if mod(j,t) == 1
            Irrigation(j) = d;
        end

        Var_x2 = [WCL(j),Precipitation_cad(j),ET_cad(j),Irrigation(j)];
        WCL(j+1) = Predict_WCL_cad(Var_x2);
end

    Y_kg = Predict_yield_cad(WCL);
    W_mm = -sum(Irrigation);
    Y_d = Y_kg*corn_price;
    W_d = W_mm*water_price;
    Net = Y_d + W_d;
    
    result = [Y_kg,W_mm,Y_d,W_d,Net];