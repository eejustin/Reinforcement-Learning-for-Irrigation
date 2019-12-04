function [Y_kg,W_mm,Y_d, W_d, Net,WCL,ET_simu,Irrigation] = Threshold(ET,Precipitation,t,d,corn_price,water_price)
WCL = zeros(84,1);
WCL(1) = 540;
Irrigation  = zeros(85,1);
runoff = zeros(84,1);
Precipitation = [0;Precipitation];
ET(84:88,1)= 0;
ET_simu = ET;

for i = 1:84
    
    if WCL(i)< t
        Irrigation(i+1) = d;
    end
    
    runoff(i+1) = Irrigation(i+1)*0.2;
    ET_simu(i+1) = min(ET(i+1)+ 0.25*Irrigation(i+1),6);
    ET_simu(i+2) = min(ET(i+2)+ 0.25*Irrigation(i+1)*0.8,6);
    ET_simu(i+3) = min(ET(i+3)+ 0.25*Irrigation(i+1)*0.8*0.8,6); 
    ET_simu(i+4) = min(ET(i+4)+ 0.25*Irrigation(i+1)*0.8*0.8*0.8,6);
        
    WCL(i+1) = WCL(i) + Precipitation(i) + Irrigation(i+1) - ET_simu(i) - runoff(i);
end

 Y_kg = myNeuralNetworkFunction(WCL)    
 W_mm = -sum(Irrigation)
 Y_d = myNeuralNetworkFunction(WCL)*corn_price    
 W_d = -sum(Irrigation)*water_price*4.065
 
 Net = Y_d + W_d