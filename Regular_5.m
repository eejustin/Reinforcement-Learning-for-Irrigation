function [result,WCL,Irrigation] = Regular_5(ET,Precipitation,t,d)
corn_price = 0.2;
water_price =1;
WCL = zeros(84,1);
WCL(1) = 540;
Irrigation  = zeros(84,1);

for j = 1:83

        if mod(j,t) == 1
            Irrigation(j) = d;
        end

        Var_x2 = [WCL(j),Precipitation(j),ET(j),Irrigation(j)];
        WCL(j+1) = Predict_WCL(Var_x2);
end

    Y_kg = myNeuralNetworkFunction(WCL);
    W_mm = -sum(Irrigation);
    Y_d = Y_kg*corn_price;
    W_d = W_mm*water_price;
    Net = Y_d + W_d;
    
    result = [Y_kg,W_mm,Y_d,W_d,Net];