clc
% import voltage data 


% import joint x,y positions data
x1 = DIPx;
y1 = DIPy;

x2 = PIPx;
y2 = PIPy;

x3 = MCPx;
y3 = MCPy;

k = 0;

for x = 1:1:802 %each x,y position of each joint has 802 points of data
    k = k + 1;

    % square of the distance between points
    ds1(k) = (x1(k) - x2(k))^2 + (y1(k) - y2(k))^2;
    ds2(k) = (x2(k) - x3(k))^2 + (y2(k) - y3(k))^2;
    ds3(k) = (x3(k) - x1(k))^2 + (y3(k) - y1(k))^2;

    % triangle side length
    A12(k) = sqrt(ds1(k));
    A23(k) = sqrt(ds2(k));
    A31(k) = sqrt(ds3(k));

    % calculate PIP joint angles in the loop
    PIP(k) = acosd((ds3(k) - ds2(k) - ds1(k)) / (-2*A12(k)*A23(k)*A31(k)))
end

% plot data points (you need to add a title and axis labels to the graph)
subplot (2,2,1)
plot(x1, y1, 'or');
hold on
subplot(2,2,2)
plot(x2,y2,'o-');
subplot(2,2,3)
plot(x3, y3, 'g*');

% plot PIP joint angles (you need to add a title and axis labels to the
% graph)
k = 1: