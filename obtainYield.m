function [R,WCL,Irrigation,runoff,ET_simu] = obtainYield(Irrigation_3,Precipitation,ET)
corn_price = 3.6;
water_price =2.2;

WCL = zeros(84,1);
WCL(1) = 540;
Irrigation = zeros(84,1);
runoff = zeros(84,1);

add_ET_loss = zeros(88,1);
ET(85:88,1) = 0;
ET_simu = zeros(88,1);



for i = 1:28
    Irrigation(i*3-2) = Irrigation_3(i);
    add_ET_loss(i*3-2) =  0.06*Irrigation_3(i);
    add_ET_loss(i*3-1) =  0.06*Irrigation_3(i)*0.8;
    add_ET_loss(i*3) =  0.06*Irrigation_3(i)*0.64;
end


    
for i = 1:84
    runoff(i) = (Irrigation(i)+ Precipitation(i))*0.12;
    ET_simu(i) = ET(i)+ add_ET_loss(i);

    
    if i < 84
       WCL(i+1) = WCL(i) + Precipitation(i) + Irrigation(i) - ET_simu(i) - runoff(i); 
    end
end
%R = myNeuralNetworkFunction(WCL)*corn_price;    
R = myNeuralNetworkFunction(WCL)*corn_price -sum(Irrigation)*water_price*4.065;