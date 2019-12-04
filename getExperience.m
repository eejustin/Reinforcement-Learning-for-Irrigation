function [trials_policy,trial_WCL,trial_Irrigation,trial_T] = getExperience(ET,Precipitation,sample_size)
 trials_policy = zeros(sample_size,9);
 trial_WCL = zeros(85,sample_size);
 trial_Irrigation = zeros(85,sample_size);
 trial_T = zeros(84,sample_size);
 
 for i = 1:sample_size
     trials_policy(i,:) = round(3*rand(1,9))+1;
     [WCL,Irrigation,ET_simu,T] = getWaterTable(trials_policy(i,:),ET,Precipitation);
     trial_WCL(:,i) = WCL;
     trial_Irrigation(:,i) = Irrigation;
     trial_T(:,i) = T;
 end
 
 