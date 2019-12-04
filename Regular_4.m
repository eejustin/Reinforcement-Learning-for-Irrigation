function [result,Y_kg,W_mm,Y_d, W_d, Net,WCL,ET_simu,Irrigation] = Regular_4(ET,Precipitation,t,d)
corn_price = 0.2;
water_price =1;

WCL = zeros(84,1);
WCL(1) = 540;
Irrigation = zeros(86,1);
runoff = zeros(84,1);

add_ET_loss = zeros(88,1);
ET(84:88,1) = 0;
ET_simu = zeros(88,1);
Precipitation = [0;Precipitation];


for i = 1:84
    
    if mod(i,t) == 1
        Irrigation(i) = d;
        add_ET_loss(i) =  0.06*d;
        add_ET_loss(i+1) =  0.06*d*0.8;
        add_ET_loss(i+2) =  0.06*d*0.64;
    end
    
    
    runoff(i) = (Irrigation(i)+ Precipitation(i))*0.12;
    ET_simu(i) = ET(i)+ add_ET_loss(i);

    
    if i < 84
       WCL(i+1) = WCL(i) + Precipitation(i) + Irrigation(i) - ET_simu(i) - runoff(i); 
    end
end
    
 Y_kg = myNeuralNetworkFunction(WCL)    
 W_mm = -sum(Irrigation)
 Y_d = myNeuralNetworkFunction(WCL)*corn_price   
 W_d = -sum(Irrigation)*water_price
 
 Net = Y_d + W_d
 result = [Y_kg,W_mm,Y_d, W_d, Net]