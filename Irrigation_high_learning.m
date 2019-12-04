function q_tab = Irrigation_high_learning(N,r_tab,lamda)
    e_tab = zeros(3,3);
    q_tab = zeros(4,3); 
    alfa = 0.5;
    gama = 0.5;
    
    action = [1, 2, 1, 2, 1];

    state = [1, 2, 3];

    for k = 1:N
        St = t;
     for t = 1:3
            St(t+1) = t+1;
            delta = r_tab(St(t),action(t))+gama*q_tab(St(t+1),action(t+1))-q_tab(St(t),action(t));
            e_tab(St(t),action(t)) = e_tab(St(t),action(t))+1;
            for i = 1:3 
                for j = 1:3
                    q_tab(i,j)= q_tab(i,j)+ alfa*e_tab(i,j)*delta;
                    e_tab(i,j)= gama*lamda*e_tab(i,j);
                end
            end
        end
     end
    end
