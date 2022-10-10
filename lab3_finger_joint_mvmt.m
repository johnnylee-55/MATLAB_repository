clc

% import joint x,y positions Tracker
t1 = timeTracker;

x1 = DIPx;
y1 = DIPy;

x2 = PIPx;
y2 = PIPy;

x3 = MCPx;
y3 = MCPy;

% loop calculates angle of PIP joint over time
k = 0;
for x = 1:1:size(PIPx) % each x,y position of each joint has 802 points of data
    k = k + 1;

    % distance between each joint
    Dist12(k) = (x1(k) - x2(k))^2 + (y1(k) - y2(k))^2;
    Dist23(k) = (x2(k) - x3(k))^2 + (y2(k) - y3(k))^2;
    Dist31(k) = (x3(k) - x1(k))^2 + (y3(k) - y1(k))^2;

    % calculate side length of each triangle
    Side12(k) = sqrt(Dist12(k));
    Side23(k) = sqrt(Dist23(k));
    Side31(k) = sqrt(Dist31(k));

    % calculate PIP joint angles from distances and side lengths
    PIPangle(k) = acosd((Dist31(k) - Dist23(k) - Dist12(k)) / (-2*Side12(k)*Side23(k)));
end

% plot X,Y positions of joints over time
subplot(2,2,1)
plot(x1, y1, 'or');
title('Position of DIP Joint over time');
xlabel('X Position of DIP Joint (cm)');
ylabel('Y Position of DIP Joint (cm)');
hold on

subplot(2,2,2)
plot(x2,y2,'o-');
title('Position of PIP Joint over time');
xlabel('X Position of PIP Joint (cm)');
ylabel('Y Position of PIP Joint (cm)');
hold on

subplot(2,2,3)
plot(x3, y3, 'g*');
title('Position of MCP Joint over time');
xlabel('X Position of MCP Joint (cm)');
ylabel('Y Position of MCP Joint (cm)');

% plot PIP joint angle over time
k = 1:1:size(PIPx);

subplot(2, 2, 4)
plot(t1(k), PIPangle(k), '--');
title('Angle of PIP Joint over time');
xlabel('Time (s)');
ylabel('Degrees');
grid on;

% import voltage data from strain gauge sensor
t2 = timeSensor;
V = voltageSensor;

% plot voltage vs time from strain gauge
figure
plot(t2,V)
title('Voltage over time from Strain Guage');
xlabel('Time (s)');
ylabel('Voltage (V)')

% prior to using QuadFit(), resample both data sets to have 800 data points
voltageRS = resample(voltageSensor, 800, 799);
angleRS = resample(PIPangle, 800, 802);

resultCoefficients = QuadFit(voltageRS, angleRS);

% plot resampled voltage/PIPangle with quadratic fit equation on top
figure
plot(voltageRS, angleRS,'b--o')
hold on
a1 = resultCoefficients(1);
a2 = resultCoefficients(2);
a3 = resultCoefficients(3);
x = 0.75:.1:2.5;
y = (a1*x.^2 + a2*x + a3); % uses coefficients calculated by QuadFit() function
plot(x,y,'r','LineWidth', 2.0)
title('Voltage vs PIPjoint Angle with Quadratic Line Fit')
xlabel('Voltage (V)')
ylabel('PIP Joint Angle Measurement (degrees)')

%{
 takes set of points (x,y) and outputs the coefficients found by the
 quadratic regression (a1, a2, a3) where y(x)= a1*x^2 + a2*x + a3
%}
function a = QuadFit(x,y)

% number of loops
n = length(x);

% find the sums needed for building two equations for solving least squares
% best-fit method
s_x1=0; s_x2=0; s_x3=0; s_x4=0;
s_y=0; s_xy=0; s_x2y=0;

for i = 1:n
    s_x1 = s_x1 + (x(i));
    s_x2 = s_x2 + (x(i)).^2;
    s_x3 = s_x3 + (x(i)).^3;
    s_x4 = s_x4 + (x(i)).^4;

    s_y = s_y + y(i);
    s_xy = s_xy + x(i)*y(i);
    s_x2y = s_x2y + x(i).^2*y(i);
end

% build matrix for Gauss Elimination method
A = [ n s_x1 s_x2 ; s_x1 s_x2 s_x3 ; s_x2 s_x3 s_x4 ];
b = [ s_y ; s_xy ; s_x2y ];

c = gauss(A,b);
a = [ c(3) c(2) c(1) ];
end

% matrix calculation using Gauss Elimination
function x = gauss(A,b)

n = length(b);
for k = 1:n-2
    for i = k+1:n
        if A(i,k) ~= 0
            lambda = A(i,k)/A(k,k);
            A(i,k+1:n) = A(i,k+1:n) - lambda * A(k,k+1:n);
            b(i) = b(i) - lambda * b(k);
        end
    end
end

% back substitution phase
for k = n:-1:1
    b(k) = (b(k) - A(k,k+1:n) * b(k+1:n)) / A(k,k);
end
x = b;
end