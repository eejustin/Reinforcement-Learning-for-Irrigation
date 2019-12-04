function [MINMAX,MINMAXARRAY,Q_tab,policy,S,A,R,WCL_3,WCL,Irrigation,Irrigation_3,runoff,ET_simu] = runMinMax(ET,Precipitation,corn_price,water_price,ref_Irrigation)
    MINMAX = zeros(1,10);
    MINMAXARRAY = zeros(84,1,10);
    YKG = zeros(1,10);
    WMM = zeros(1,10);
    YD = zeros(1,10);
    WD = zeros(1,10);
    NET = zeros(1,10);
for i = 1:10
    [min_max_yield,min_max,min_max_array,Q_tab,policy,S,A,R,WCL_3,WCL,Irrigation,Irrigation_3,runoff,ET_simu] = TestCode(ET,Precipitation,corn_price,water_price,ref_Irrigation);
    MINMAX(i) = min_max;
    MINMAXARRAY(:,:,i) = min_max_array;
    YKG(i) = min_max_yield/corn_price;   
    WMM(i) = -sum(min_max_array);
    YD(i) = min_max_yield;    
    WD(i) = -sum(min_max_array)*water_price*4.065;
 
    NET(i) = YD(i)+WD(i);
end

    