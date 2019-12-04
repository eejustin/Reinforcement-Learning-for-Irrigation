function [result,WCL,ET_simu,Irrigation] = Manual_4(ET,Precipitation,irrigation)
corn_price = 3.6;
water_price = 2.2;
WCL = zeros(84,1);
WCL(1) = 540;
Irrigation = zeros(86,1);
runoff = zeros(84,1);

add_ET_loss = zeros(88,1);
ET(84:88,1) = 0;
ET_simu = zeros(88,1);
Precipitation = [0;Precipitation];

for i = 1:28
    Irrigation(i*3-2) = irrigation(i);
    add_ET_loss(i*3-2) =  0.06*irrigation(i);
    add_ET_loss(i*3-1) =  0.06*irrigation(i)*0.8;
    add_ET_loss(i*3) =  0.06*irrigation(i)*0.64;
end


for i = 1:84
    
    runoff(i) = (Irrigation(i)+ Precipitation(i))*0.12;
    ET_simu(i) = ET(i)+ add_ET_loss(i);

    
    if i < 84
       WCL(i+1) = WCL(i) + Precipitation(i) + Irrigation(i) - ET_simu(i) - runoff(i); 
    end
end
    
 Y_kg = myNeuralNetworkFunction(WCL);    
 W_mm = -sum(Irrigation);
 Y_d = myNeuralNetworkFunction(WCL)*corn_price ;  
 W_d = -sum(Irrigation)*water_price*4.065;
 
 Net = Y_d + W_d;
 result = [Y_kg,W_mm,Y_d, W_d, Net]