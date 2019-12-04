function PDSA = getPD(DS, PSS)
PDSA = zeros(10,10,10);  % PSDA(s,d,a)
for a = 1:10
    PDSA(:,:,a) = PSS(:,:,a)*transpose(DS);
end




