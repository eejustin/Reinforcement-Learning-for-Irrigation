function [Y_kg,W_mm,Y_d, W_d, Net] = yield(ET,Precipitation,corn_price,water_price,policy)

 [WCL,Irrigation,ET_simu,S,runoff] = getWaterTable(policy,ET,Precipitation);
 Y_kg = myNeuralNetworkFunction(WCL)    
 W_mm = -sum(Irrigation)
 Y_d = myNeuralNetworkFunction(WCL)*corn_price    
 W_d = -sum(Irrigation)*water_price*4.065
 
 Net = Y_d + W_d