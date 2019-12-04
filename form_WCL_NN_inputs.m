function WCL_NN_inputs = form_WCL_NN_inputs(yield_NN_inputs,Irrigation,Precipitation,ET)
[r,c] = size(yield_NN_inputs);
WCL_NN_inputs = zeros((r-1)*c,4);
for i = 1:c
    for j = 1:r-1
        WCL_NN_inputs(j+(r-1)*(i-1),1) = yield_NN_inputs(j,i);
        WCL_NN_inputs(j+(r-1)*(i-1),2) = Precipitation(j,1);
        WCL_NN_inputs(j+(r-1)*(i-1),3) = ET(j,1);
        WCL_NN_inputs(j+(r-1)*(i-1),4) = Irrigation(j,i);
    end
end