function [Q_tab, policy,trial_policy,trial_WCL,trial_Irrigation,trial_T] = TD_3(lamda,ET,Precipitation,corn_price,water_price,sample_size)
Q_tab = zeros(9,4);
Q_tab_record = ones(9,4);
e_tab = zeros(8,4);
policy = zeros(1,8);

 alfa = 0.1;
 gama = 0.5;
 threshold = 0.1;
 trial_policy = zeros(sample_size,9);
 trial_WCL = zeros(85,sample_size);
 trial_Irrigation = zeros(85,sample_size);
 trial_T = zeros(84,sample_size);
 
 for i = 1:sample_size
     trial_policy(i,:) = round(3*rand(1,9))+1;
     [WCL,Irrigation,ET_simu,T] = getWaterTable(trial_policy(i,:),ET,Precipitation);
     trial_WCL(:,i) = WCL;
     trial_Irrigation(:,i) = Irrigation;
     trial_T(:,i) = T;
 end
 
 M = 0;
 
 trial_T(85,:) = 9;
 
while sum(sum(abs(Q_tab_record-Q_tab)))> threshold
   M = M+1; 
   Q_tab_record = Q_tab;
   
   for i = 1:sample_size
       r = zeros(1,84);
       for j = 1:84
            if j<84
                r(j) = -trial_Irrigation(j,i)*water_price*4.065;
            elseif j == 84
                r(j) = myNeuralNetworkFunction(trial_WCL(:,i))*corn_price;
            end
            

            delta = r(j)+gama*Q_tab(trial_T(j+1,i),trial_policy(i,trial_T(j+1,i)))-Q_tab(trial_T(j,i),trial_policy(i,trial_T(j,i)));
            e_tab(trial_T(j,i),trial_policy(i,trial_T(j,i))) = e_tab(trial_T(j,i),trial_policy(i,trial_T(j,i)))+1;

             for s = 1:8 
                    for a = 1:4
                        Q_tab(s,a)= Q_tab(s,a)+ alfa*e_tab(s,a)*delta;
                        e_tab(s,a)= gama*lamda*e_tab(s,a);
                    end
             end
       end
   end
end

 
fprintf('%d',M); 


for s = 1:8
    [argvalue, argmax]= max(Q_tab(s,:));
     policy(s) = argmax;
end 

         