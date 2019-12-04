function S = getState_5(i,WCL)

    if i <= 21
        if WCL <= 540
            S = 1;
        elseif WCL <= 545
            S = 2;
        elseif WCL <= 550
            S = 3;
        elseif WCL <= 560
            S = 4;    
        else 
            S = 5;
        end
        
    elseif i<= 45
        if WCL <= 540
            S = 6;
        elseif WCL <= 545
            S = 7;
        elseif WCL <= 550
            S = 8;
        elseif WCL <= 560
            S = 9;
        else 
            S = 10;
        end
        
    elseif i<=63
        if WCL <= 540
            S = 11;
        elseif WCL <= 545
            S = 12;
        elseif WCL <= 550
            S = 13;
        elseif WCL <= 560
            S = 14;
        else 
            S = 15;
        end
        
    else
        if WCL <= 540
            S = 16;
        elseif WCL <= 545
            S = 17;
        elseif WCL <= 550
            S = 18;
        elseif WCL <= 560
            S = 19;
        else 
            S = 20;
        end
        
    end