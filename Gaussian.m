function fun = Gaussian(m,sd)
a = sd.*sqrt(2*pi);
c = 2*(sd.^2);
fun = @(x)(a.^(-1)).*exp((-1)*(x-m).^2./c);
