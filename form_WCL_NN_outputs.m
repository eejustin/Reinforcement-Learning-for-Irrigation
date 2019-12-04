function WCL_NN_outputs = form_WCL_NN_outputs(yield_NN_inputs)
[r,c] = size(yield_NN_inputs);
WCL_NN_outputs = zeros((r-1)*c,1);
for i = 1:c
    for j = 1:r-1
        WCL_NN_outputs(j+(r-1)*(i-1),1) = yield_NN_inputs(j+1,i);

    end
end