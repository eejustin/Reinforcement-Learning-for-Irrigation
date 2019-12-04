function q_tab = GetQ(N)

    e_tab = zeros(2,2);
    q_tab = zeros(3,2);
    r_tab = zeros(2,2);
    r_tab(2,2) = 1;
    alfa = 0.5;
    gama = 0.5;
    lamda = 0.5;
    action = [1, 2, 1, 2, 1];
    T = [1, 2 ; 2, 3];
    state = [1, 2, 3];

    for k = 1:N
        St = [];
        St(1) = state(1);

     for t = 1:5
        if (t==5)
            St(t+1) = 3;
        else
            St(t+1) = T(St(t),action(t));
            delta = r_tab(St(t),action(t))+gama*q_tab(St(t+1),action(t+1))-q_tab(St(t),action(t));
            e_tab(St(t),action(t)) = e_tab(St(t),action(t))+1;
            for i = 1:2 
                for j = 1:2
                    q_tab(i,j)= q_tab(i,j)+ alfa*e_tab(i,j)*delta;
                    e_tab(i,j)= gama*lamda*e_tab(i,j);
                end
            end
        end
     end
    end
