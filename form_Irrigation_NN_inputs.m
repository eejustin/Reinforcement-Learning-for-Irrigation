function [Irrigation_NN_inputs,Irrigation_NN_outputs] = form_Irrigation_NN_inputs(WCL_NN_inputs,WCL_NN_outputs)

Irrigation_NN_inputs = WCL_NN_inputs;
Irrigation_NN_inputs(:,2) = WCL_NN_outputs;
Irrigation_NN_inputs(:,3:4) = WCL_NN_inputs(:,2:3);
Irrigation_NN_outputs = WCL_NN_inputs(:,4);
