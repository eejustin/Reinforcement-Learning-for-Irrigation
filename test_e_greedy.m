function N = test_e_greedy(epsilon,Q_tab,S)
N = 0;
for i = 1:100
    A(i) = e_greedy(epsilon,Q_tab,S);
    if A(i) == 4
        N = N+1;
    end
end

