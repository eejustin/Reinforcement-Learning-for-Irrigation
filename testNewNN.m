function y = testNewNN(x)
[r,c] = size(x);
y = zeros(r,1);
for i = 1:r
    y(i) = myNeuralNetworkFunction_2(x(i,:));
end

    