function [Q_tab, policy] = TD(lamda,r_tab,trial)
 e_tab = zeros(3,3);
 Q_tab = zeros(4,3); 
 Q_tab_record = ones(4,3); 
 alfa = 0.5;
 gama = 0.5;
 action = [0,0,0,1];
 St = [1,2,3,4];
 threshold = 0.1;
 policy = zeros(1,3);
 M = 0;
 sz = size(trial);
 
while sum(sum(abs(Q_tab_record-Q_tab)))> threshold
   M = M+1; 
   Q_tab_record = Q_tab;
    for N = 1:sz(1)
     a1 = trial(N,1);
     a2 = trial(N,2);
     a3 = trial(N,3);
     r = zeros(3,3);
     
     for t = 1:3
         action(t) = trial(N,t);
         if t < 3
         action(t+1) = trial(N,t+1);
         end
         if St(t) == 3
            r(St(t),action(t)) = r_tab(a1,a2,a3);
         end
         delta = r(St(t),action(t))+gama*Q_tab(St(t+1),action(t+1))-Q_tab(St(t),action(t));
         e_tab(St(t),action(t)) = e_tab(St(t),action(t))+1;
         for s = 1:3 
                for a = 1:3
                    Q_tab(s,a)= Q_tab(s,a)+ alfa*e_tab(s,a)*delta;
                    e_tab(s,a)= gama*lamda*e_tab(s,a);
                end
         end
     end
    end
end
fprintf('%d',M); 


for s = 1:3
    [argvalue, argmax]= max(Q_tab(s,:));
     policy(s) = argmax;
end         
         