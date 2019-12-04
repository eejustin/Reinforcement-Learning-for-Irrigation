function y = Ep()
y = zeros(1,101);
for M = 0:20
    y(M+1) = 0.2+0.8*(1-sqrt(1/(M+1)));
end
