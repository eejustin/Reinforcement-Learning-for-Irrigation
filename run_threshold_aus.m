function [RESULT,WCL_tab] = run_threshold_aus(ET_aus,Precipitation_aus)
RESULT = zeros(9,7);
WCL_tab = zeros(93,9);
t = 540;
d = 10;
M = 1;
for i = 1:3
    for j = 1:3
        [result,WCL,Irrigation_3] = Threshold_5_aus(ET_aus,Precipitation_aus,t,d);
        WCL_tab(:,M) = WCL;
        RESULT(M,1) = t;
        RESULT(M,2) = d;
        RESULT(M,3:7) = result;
        d = d+10;
        M = M+1;
    end
    d = 10;
    t = t+10;
end