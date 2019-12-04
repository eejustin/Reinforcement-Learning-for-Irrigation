function [WCL,Irrigation,ET_simu,S,runoff] = getWaterTable(policy,ET,Precipitation)
WCL = zeros(84,1);
WCL(1) = 540;
Irrigation  = zeros(84,1);
policy(4) = 1;
policy(8) = 1;
policy(12)= 1;

S = zeros(84,1);
Actions = [0,555,565,575];
ET(84:88,1)= 0;
ET_simu = ET;
runoff = zeros(84,1);
Precipitation = [0;Precipitation];

for i = 1:84
    S(i) = getState(i,WCL(i));
    
    if policy(S(i))== 1
            Irrigation(i+1) = 0;
    else
        if WCL(i)> Actions(policy(S(i)))
            Irrigation(i+1) = 0;
        else
            Irrigation(i+1) = max(Actions(policy(S(i)))-Precipitation(i) + ET_simu(i)- WCL(i),0);
        end
            runoff(i+1) = Irrigation(i+1)*0.2;
            ET_simu(i+1) = min(ET(i+1)+ 0.25*Irrigation(i+1),6);
            ET_simu(i+2) = min(ET(i+2)+ 0.25*Irrigation(i+1)*0.8,6);
            ET_simu(i+3) = min(ET(i+3)+ 0.25*Irrigation(i+1)*0.8*0.8,6); 
            ET_simu(i+4) = min(ET(i+4)+ 0.25*Irrigation(i+1)*0.8*0.8*0.8,6);
        
        
    end
        
    
    
    WCL(i+1) = WCL(i) + Precipitation(i) + Irrigation(i+1) - ET_simu(i) - runoff(i);
end


    
