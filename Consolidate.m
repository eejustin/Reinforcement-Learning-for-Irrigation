function output = Consolidate(input,compression_ratio)
[r,c] = size(input);
cr = compression_ratio;
n_r = floor((r-1)/cr)+1;
output = zeros(n_r,1);
for i = 1:r 
    index = floor((i-1)/cr)+1;
    output(index) = output(index)+ input(i);
end
