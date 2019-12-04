function [N, Q_tab, policy] = Monte_carlo_2(T,A,R)
Q_tab = zeros(9,3);
N = zeros(9,3);
policy = zeros(1,9);
[episode,t]= size(T);

for i = 1:episode
    for j = 1:t
        Q_tab(T(i,j),A(i,j)) =  Q_tab(T(i,j),A(i,j)) + R(i);
        N(T(i,j),A(i,j)) =  N(T(i,j),A(i,j)) + 1;
    end
end

Q_tab = Q_tab./N;

for s = 1:9
    [argvalue, argmax]= max(Q_tab(s,:));
     policy(s) = argmax;
end

