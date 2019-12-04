function [Q_tab, policy] = TD_2(lamda,T,A,R)
Q_tab = zeros(10,3);
Q_tab_record = ones(10,3);
e_tab = zeros(9,3);
[episode,t]= size(T);

 alfa = 0.5;
 gama = 0.5;
 threshold = 0.1;
 policy = zeros(1,9);
 M = 0;
 
while sum(sum(abs(Q_tab_record-Q_tab)))> threshold
   M = M+1; 
   Q_tab_record = Q_tab;
   
   for i = 1:episode
       r = zeros(1,t);
       r(t-1) = R(i);
       St = T(i,:);
       action = A(i,:);
    for j = 1:t-1
        delta = r(j)+gama*Q_tab(St(j+1),action(j+1))-Q_tab(St(j),action(j));
        e_tab(St(j),action(j)) = e_tab(St(j),action(j))+1;
         
         for s = 1:9 
                for a = 1:3
                    Q_tab(s,a)= Q_tab(s,a)+ alfa*e_tab(s,a)*delta;
                    e_tab(s,a)= gama*lamda*e_tab(s,a);
                end
         end
    end
   end
end
 
fprintf('%d',M); 


for s = 1:9
    [argvalue, argmax]= max(Q_tab(s,:));
     policy(s) = argmax;
end         
         