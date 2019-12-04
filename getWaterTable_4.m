function [Y_kg,W_mm,Y_d,W_d,Net, WCL,Irrigation,ET_simu,S,runoff,A] = getWaterTable_4(policy,ET,Precipitation)
    corn_price = 3.6;
    water_price =2.2;

    ET_3 = Consolidate(ET,3);
    Precipitation_3 = Consolidate(Precipitation,3);
    Actions = [0,560,570,580];
    ET_simu_3 = ET_3;
    runoff_3 = zeros(28,1);
    WCL_3 = zeros(28,1);
    WCL_3(1) = 540;
    Irrigation_3  = zeros(28,1);
    R = zeros(28,1);
    S = zeros(28,1);
    A = zeros(28,1);

    
    for i = 1:28
        
            S(i) = getState_4(i,WCL_3(i));
            A(i) = policy(S(i));


            if A(i) == 1
                    Irrigation_3(i) = 0;
            else
                if WCL_3(i)+Precipitation_3(i)>= Actions(A(i))
                    Irrigation_3(i) = 0;
                else
                    Irrigation_3(i) = max(Actions(A(i))-Precipitation_3(i) - WCL_3(i),0);               
                end
            end

            runoff_3(i) = (Irrigation_3(i)+ Precipitation_3(i))*0.12;
            ET_simu_3(i) = ET_3(i)+ 0.06*Irrigation_3(i)*2.44; 
            WCL_3(i+1) = WCL_3(i) + Precipitation_3(i) + Irrigation_3(i) - ET_simu_3(i) - runoff_3(i); 

            if i < 28
                S(i+1) = getState(i+1,WCL_3(i+1));
                A(i+1) = policy(S(i+1));
            elseif i == 28
                S(i+1) = 21;
                A(i+1) = 1;
                [R(i),WCL,Irrigation,runoff,ET_simu] = obtainYield(Irrigation_3,Precipitation,ET);
                
            end

    end
    
    
 W_mm = -sum(Irrigation);
 W_d = W_mm*water_price*4.065;
 Y_d = R(28)- W_d; 
 Y_kg = Y_d/corn_price;  
 
 
 Net = R(28);
    