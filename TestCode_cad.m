function [Q_tab,policy,S,A,R,WCL_3,WCL,Irrigation_3] = TestCode_cad(ET_cad,Precipitation_cad)
corn_price = 0.2;
water_price =1;

Q_tab = zeros(20,4);
Q_tab(21,:) = 0;
Q_tab_record = ones(21,4);

%policy = updatePolicy(Q_tab);
%policy_record = zeros(1,20);

alfa = 0.05;
gama = 0.9;
threshold = 1; 

Actions = [0,340,350,360];

lamda = 0.9;
M = 0;


while M < 500
    %Q_tab_record = Q_tab;
    
    if M < 300
        epsilon = 0.3+0.002*M;
    else
        epsilon = 1-sqrt(1/(M+1));
    end
    M = M+1
    
    WCL_3 = zeros(34,1);
    WCL_3(1) = 359;
    WCL = zeros(102,1);
    WCL(1) = 359;
    Irrigation_3  = zeros(34,1);
    R = zeros(34,1);
    S = zeros(34,1);
    A = zeros(34,1);
    e_tab = zeros(34,4);
    
    for i = 1:5
        S(i) = getState_cad(i,WCL_3(i));
        A(i) = 1;
        [Irrigation_3,WCL_3,WCL] = Irri_WCL_Predict_cad(WCL,A(i),Precipitation_cad,ET_cad,Irrigation_3,WCL_3,i);
    end
    
    for i = 6:34
        if i == 6
            S(6) = getState_cad(6,WCL_3(6));
            A(6) = e_greedy(epsilon,Q_tab,S(6));
        end
        
        [Irrigation_3,WCL_3,WCL] = Irri_WCL_Predict_cad(WCL,A(i),Precipitation_cad,ET_cad,Irrigation_3,WCL_3,i);

            if i < 34
                S(i+1) = getState_cad(i+1,WCL_3(i+1));
                A(i+1) = e_greedy(epsilon,Q_tab,S(i+1));
                %R(i) = -Irrigation_3(i)*water_price*4.065;
            elseif i == 34
                S(i+1) = 21;
                A(i+1) = 1;
                yield = Predict_yield_cad(WCL);
                water_consum = sum(Irrigation_3);
                R(i) = yield*corn_price - water_consum*water_price;
                if R(i) < 1400
                    R(i) = -5;
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
           
