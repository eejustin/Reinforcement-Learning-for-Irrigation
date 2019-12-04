function S = getState_cad(i,WCL)

    if i <= 13
        if WCL <= 320
            S = 1;
        elseif WCL <= 325
            S = 2;
        elseif WCL <= 330
            S = 3;
        elseif WCL <= 340
            S = 4;    
        else 
            S = 5;
        end
        
    elseif i<= 20
        if WCL <= 320
            S = 6;
        elseif WCL <= 325
            S = 7;
        elseif WCL <= 330
            S = 8;
        elseif WCL <= 340
            S = 9;
        else 
            S = 10;
        end
        
    elseif i<=27
        if WCL <= 320
            S = 11;
        elseif WCL <= 325
            S = 12;
        elseif WCL <= 330
            S = 13;
        elseif WCL <= 340
            S = 14;
        else 
            S = 15;
        end
        
    else
        if WCL <= 320
            S = 16;
        elseif WCL <= 325
            S = 17;
        elseif WCL <= 330
            S = 18;
        elseif WCL <= 340
            S = 19;
        else 
            S = 20;
        end
        
    end