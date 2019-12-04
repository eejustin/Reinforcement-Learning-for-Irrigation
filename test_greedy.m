function [a1,a2,a3,a4]=test_greedy(n,Q_tab)
a1 = 0;
a2 = 0;
a3 = 0;
a4 = 0;
S = 1;
A = zeros(n,1);
epsilon = 0.5;
for i = 1:n
    A(i) = e_greedy(epsilon,Q_tab,S);
    if A(i) == 1
        a1 = a1+1;
    elseif A(i) == 2
        a2 = a2+1;
    elseif A(i) == 3
        a3 = a3+1;
    elseif A(i) == 4
        a4 = a4+1;
    end
end

a1
a2
a3
a4
