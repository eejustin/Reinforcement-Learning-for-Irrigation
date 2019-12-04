function A = e_greedy(epsilon,Q_tab,S)
[r,c] = size(Q_tab);
options = zeros(1,c);
for i = 1:c
    options(i) = i;
end

rng shuffle;
x = rand;
[argvalue, argmax] = max(Q_tab(S,:));
if x < epsilon
    A = argmax;
else
    options(argmax) = [];
    rng shuffle;
    y = rand;
    index = floor(y*(c-1))+1;
    A = options(index);
end

    
