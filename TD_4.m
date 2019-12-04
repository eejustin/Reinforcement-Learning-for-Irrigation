function [Q_tab, policy] = TD_4(lamda,ET,Precipitation,corn_price,water_price)

Q_tab = zeros(12,4);
Q_tab(13,:) = 0;
Q_tab(4,2:4) = 0;
Q_tab(8,2:4) = 0;
Q_tab(12,2:4) = 0;

Q_tab_record = zeros(13,4);
e_tab = zeros(12,4);
policy = updatePolicy(Q_tab);
policy_record = zeros(1,12);
policy(4) = 1;
policy(8) = 1;
policy(12)= 1;


alfa = 0.1;
gama = 0.5;
threshold = 1;
Precipitation = [0;Precipitation];
ET(84:88,1)= 0;
Actions = [0,555,565,575];
M = 0;


 
%while sum(sum(abs(Q_tab_record-Q_tab)))> threshold
for n = 1:10
    M = M+1; 
    if mod(M,10) == 0
        M
        epsilon
        policy
    end
    Q_tab_record = Q_tab;
    policy_record = policy; 
    
        

    ET_simu = ET;
    runoff = zeros(84,1);
    WCL = zeros(84,1);
    WCL(1) = 540;
    Irrigation  = zeros(84,1);
    R = zeros(84,1);
    S = zeros(84,1);
    A = zeros(85,1);
    epsilon = 1-sqrt(1/(M+1));

    for i = 1:28
        S(i) = getState(i,WCL(i));
        A(i) = e_greedy(epsilon,Q_tab,S(i));
        %if S(i) == 4 || S(i) ==8 || S(i) ==12
            %A(i) = 1;
        %end
        
        

        if A(i) == 1
                Irrigation(i+1) = 0;
        else
            if WCL(i)> Actions(A(i))
                Irrigation(i+1) = 0;
            else
                Irrigation(i+1) = max(Actions(A(i))-Precipitation(i) + ET_simu(i)- WCL(i),0);
            end
                runoff(i+1) = Irrigation(i+1)*0.2;
                ET_simu(i+1) = min(ET(i+1)+ 0.25*Irrigation(i+1),6);
                ET_simu(i+2) = min(ET(i+2)+ 0.25*Irrigation(i+1)*0.8,6);
                ET_simu(i+3) = min(ET(i+3)+ 0.25*Irrigation(i+1)*0.8*0.8,6); 
                ET_simu(i+4) = min(ET(i+4)+ 0.25*Irrigation(i+1)*0.8*0.8*0.8,6);         
        end

        WCL(i+1) = WCL(i) + Precipitation(i) + Irrigation(i+1) - ET_simu(i) - runoff(i);
        
        if i < 84
            S(i+1) = getState(i+1,WCL(i+1));
            A(i+1) = e_greedy(epsilon,Q_tab,S(i+1));
            R(i+1) = -Irrigation(i+1)*water_price*4.065;
        elseif i == 84
            S(i+1) = 13;
            A(i+1) = 1;
            R(i) = myNeuralNetworkFunction(WCL)*corn_price;
        end

        delta = R(i)+gama*Q_tab(S(i+1),A(i+1)) - Q_tab(S(i),A(i));
        e_tab(S(i),A(i)) = e_tab(S(i),A(i)) + 1;

        for s = 1:12
            for a = 1:4
                Q_tab(s,a)= Q_tab(s,a)+ alfa*e_tab(s,a)*delta;
                e_tab(s,a)= gama*lamda*e_tab(s,a);
            end
        end
        
    end
    
    for s = 1:12
    [argvalue, argmax]= max(Q_tab(s,:));
     policy(s) = argmax;
     
    end
end



    
    
    




