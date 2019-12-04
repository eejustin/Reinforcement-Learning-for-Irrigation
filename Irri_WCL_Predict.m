function [Irrigation_3,WCL_3,WCL] = Irri_WCL_Predict(WCL,A,Precipitation,ET,Irrigation_3,WCL_3,i)
j = (i-1)*3+1;
Actions = [0,560,570,580];


Var_x1 = [WCL(j),Actions(A),Precipitation(j),ET(j)];
Irrigation_3(i) = Predict_Irrigation(Var_x1);

if Irrigation_3(i) < 20 
    Irrigation_3(i) = 0;
end

Var_x2 = [WCL(j),Precipitation(j),ET(j),Irrigation_3(i)];
WCL(j+1) = Predict_WCL(Var_x2);
Var_x3 = [WCL(j+1),Precipitation(j+1),ET(j+1),0];
WCL(j+2) = Predict_WCL(Var_x3);

if j < 82
    Var_x4 = [WCL(j+2),Precipitation(j+2),ET(j+2),0];
    WCL(j+3) = Predict_WCL(Var_x4);
    WCL_3(i+1) = WCL(j+3);
end
