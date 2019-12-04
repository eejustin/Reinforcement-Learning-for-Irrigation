function [Q_tab,policy,S,A,R,WCL_3,WCL,Irrigation_3] = TestCode_2(ET,Precipitation)
corn_price = 0.2;
water_price =1;

Q_tab = zeros(20,4);
Q_tab(21,:) = 0;
Q_tab_record = ones(21,5);

%policy = updatePolicy(Q_tab);
%policy_record = zeros(1,20);

alfa = 0.05;
gama = 0.9;
threshold = 1; 

Actions = [0,560,570,580];

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
    
    WCL_3 = zeros(28,1);
    WCL_3(1) = 540;
    WCL = zeros(84,1);
    WCL(1) = 540;
    Irrigation_3  = zeros(28,1);
    R = zeros(28,1);
    S = zeros(28,1);
    A = zeros(28,1);
    e_tab = zeros(20,5);
    
    for i = 1:28
        if i == 1
            S(1) = getState_4(1,WCL_3(1));
            A(1) = e_greedy(epsilon,Q_tab,S(1));
        end
        
        [Irrigation_3,WCL_3,WCL] = Irri_WCL_Predict(WCL,A(i),Precipitation,ET,Irrigation_3,WCL_3,i);

            if i < 28
                S(i+1) = getState_4(i+1,WCL_3(i+1));
                A(i+1) = e_greedy(epsilon,Q_tab,S(i+1));
                %R(i) = -Irrigation_3(i)*water_price;
            elseif i == 28
                S(i+1) = 21;
                A(i+1) = 1;
                yield = myNeuralNetworkFunction(WCL);
                water_consum = sum(Irrigation_3);
                R(28) = yield*corn_price - water_consum*water_price;
                if R(28) < 1500
                    R(28) = -5;
                end
                
                %R(28)
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
           
