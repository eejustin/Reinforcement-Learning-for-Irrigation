function [Q_tab, policy] = Monte_carlo(r_tab)
Q_tab = zeros(3,3);
N = zeros(3,3);
policy = zeros(1,3);
for a1 = 1:3
    for a2 = 1:3
        for a3 = 1:3
            Q_tab(1,a1) = Q_tab(1,a1)+r_tab(a1,a2,a3);
            N(1,a1) = N(1,a1)+1;
            Q_tab(2,a2) = Q_tab(2,a2)+r_tab(a1,a2,a3);
            N(2,a2) = N(2,a2)+1;
            Q_tab(3,a3) = Q_tab(3,a3)+r_tab(a1,a2,a3);
            N(3,a3) = N(3,a3)+1;
        end
    end
end

Q_tab = Q_tab./N;

for s = 1:3
    [argvalue, argmax]= max(Q_tab(s,:));
     policy(s) = argmax;
end

