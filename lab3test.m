a1 = resultCoefficients(1);
a2 = resultCoefficients(2);
a3 = resultCoefficients(3);
% range of the function
x = 0:.1:2.5;

% quadratic equation
y = (a1*x.^2 + a2*x + a3);

plot(x,y)