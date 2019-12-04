function DS = generateDS(sd)
DS = zeros(10,10);
for d = 1:10
    for s = 1:10
        DS(d,s) = getP(s,d,sd);
    end
end
