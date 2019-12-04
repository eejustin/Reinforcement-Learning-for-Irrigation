function policy = updatePolicy(Q_tab)
[r,c] = size(Q_tab);
policy = zeros(1,r-1);
for s = 1:r-1
    [argvalue, argmax]= max(Q_tab(s,:));
     policy(s) = argmax;
end
