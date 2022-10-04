clc

% import joint x,y positions Tracker
t1 = timeTracker;

x1 = DIPx;
y1 = DIPy;

x2 = PIPx;
y2 = PIPy;

x3 = MCPx;
y3 = MCPy;

k = 0;
for x = 1:1:802 %each x,y position of each joint has 802 points of data
    k = k + 1;

    % distance between each joint
    D12(k) = (x1(k) - x2(k))^2 + (y1(k) - y2(k))^2;
    D23(k) = (x2(k) - x3(k))^2 + (y2(k) - y3(k))^2;
    D31(k) = (x3(k) - x1(k))^2 + (y3(k) - y1(k))^2;

    % calculate side length of each triangle
    S12(k) = sqrt(D12(k));
    S23(k) = sqrt(D23(k));
    S31(k) = sqrt(D31(k));

    % calculate PIP joint angles from distances and side lengths
    PIPangle(k) = acosd((D31(k) - D23(k) - D12(k)) / (-2*S12(k)*S23(k)));
end

% plot data points
subplot (2,2,1)
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

% plot PIP joint angle over time (you need to add a title and axis labels to the
% graph)
k = 1:1:802; % length of data is 802

subplot (2, 2, 4)
plot(t1(k), PIPangle(k), '--');
title('Angle of PIP Joint over time');
xlabel('time (s)');
ylabel('Degrees');
grid on;

% import voltage data from strain guage sensor
t2 = timeSensor;
V = voltageSensor;
% plot voltage vs time from strain guage
figure
plot(t2,V)
title('Voltage over time from Strain Guage');
xlabel('time (s)');
ylabel('Voltage (V)')

% resample data sets here

% prior to using QuadFit, data must be resampled to have the same length
resultCoefficients = QuadFit(voltageSensor, PIPangle)

function a = QuadFit(x,y)
% takes set of points (x,y) and outputs the coefficients found by the
% quadratic regression (a0, a1, a2) where y(x)= a2*x^2 + a1*x + a0

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

% matrix set up
A = [ n s_x1 s_x2 ; s_x1 s_x2 s_x3 ; s_x2 s_x3 s_x4 ];
b = [ s_y ; s_xy ; s_x2y ];

c = gauss(A,b);
a = [ c(3) c(2) c(1) ];
end

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