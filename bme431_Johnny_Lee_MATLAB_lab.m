% BME 431 - MATLAB Lab: Neuron as an RC Circuit

%{
V(dot) + 4V = -50
    V(dot)i = -50 - 4Vi
V(0) = -60
for 0 < t < 2
dt = 0.1s
%}
clc
clear

syms V(t)
ode = diff(V,t) + 4*V == -50;
cond = V(0) == -60;

% solution to equation
vSol(t) = dsolve(ode, cond)

% declaring vectors and indexes for while loop
t = 0;
index = 1;
time = zeros(1, 20);
Voltage = zeros(1, 20);

while (t < 2)
    % assign values to matrix
    time(index) = t;
    Voltage(index) = vSol(t);

    % increment indexes
    index = index + 1;
    t = t + 0.1;
end

% plot graph
plot(time,Voltage)
title("Neuron as an RC Circuit - Depolarization of the Cell Membrane")
xlabel("time (s)")
ylabel("voltage (mV)")