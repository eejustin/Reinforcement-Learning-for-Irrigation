function [Q_tab,policy,S,A,R,WCL_3,WCL,Irrigation,Irrigation_3,runoff,ET_simu] = TestCode(ET,Precipitation)
corn_price = 3.6;
water_price =2.2;

Q_tab = zeros(20,4);
Q_tab(21,:) = 0;
Q_tab_record = ones(21,4);
e_tab = zeros(20,4);
%policy = updatePolicy(Q_tab);
%policy_record = zeros(1,20);

alfa = 0.05;
gama = 0.9;
threshold = 1; 


ET_3 = Consolidate(ET,3);
Precipitation_3 = Consolidate(Precipitation,3);
Actions = [0,560,570,580];

lamda = 0.9;
M = 0;

while M < 800
    %Q_tab_record = Q_tab;
    
    if M < 500
        epsilon = 0.0018*M;
    else
        epsilon = 1-sqrt(1/(M+1));
    end
    M = M+1
    
    ET_simu_3 = ET_3;
    runoff_3 = zeros(28,1);
    WCL_3 = zeros(28,1);
    WCL_3(1) = 540;
    Irrigation_3  = zeros(28,1);
    R = zeros(28,1);
    S = zeros(28,1);
    A = zeros(28,1);
    e_tab = zeros(20,4);
    
    for i = 1:28
        if i == 1
            S(1) = getState_4(1,WCL_3(1));
            A(1) = e_greedy(epsilon,Q_tab,S(1));
        end

            
            
            

            runoff_3(i) = (Irrigation_3(i)+ Precipitation_3(i))*0.12;
            ET_simu_3(i) = ET_3(i)+ 0.06*Irrigation_3(i)*2.44; 
            WCL_3(i+1) = WCL_3(i) + Precipitation_3(i) + Irrigation_3(i) - ET_simu_3(i) - runoff_3(i); 

            if i < 28
                S(i+1) = getState_4(i+1,WCL_3(i+1));
                A(i+1) = e_greedy(epsilon,Q_tab,S(i+1));
                %R(i) = -Irrigation_3(i)*water_price*4.065;
            elseif i == 28
                S(i+1) = 21;
                A(i+1) = 1;
                [R(i),WCL,Irrigation,runoff,ET_simu] = obtainYield(Irrigation_3,Precipitation,ET);
                
                if R(28) < 33000
                    R(28) = -50;
                end

            end

            delta = R(i)+gama*Q_tab(S(i+1),A(i+1)) - Q_tab(S(i),A(i));
            e_tab(S(i),A(i)) = e_tab(S(i),A(i)) + 1;

            for s = 1:20
                for a = 1:4
                    Q_tab(s,a)= Q_tab(s,a)+ alfa*e_tab(s,a)*delta;
                    e_tab(s,a)= gama*lamda*e_tab(s,a);
                    
                end
            end
    end
    
    for s = 1:20
       [argvalue, argmax]= max(Q_tab(s,:));
       policy(s) = argmax;
    end
    policy
end
           
