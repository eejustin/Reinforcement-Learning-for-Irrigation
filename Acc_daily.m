function Irrigation = Acc_daily(Acc_Irrigation)
[r,c] = size(Acc_Irrigation);
Irrigation = zeros(r-1,c);
for n = 1:c
    
    for i = 1:r-1
        if Acc_Irrigation(i,n) ~= Acc_Irrigation(i+1,n)
            Irrigation(i,n) = Acc_Irrigation(i+1,n)- Acc_Irrigation(i,n);
        end
    end
end
