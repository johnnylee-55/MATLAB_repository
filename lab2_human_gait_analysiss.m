clc
% 3.a
% plot hip joint movement
figure
plot(A1, A2)
title("Movement of Hip joint");
xlabel("horizontal distance (m)");
ylabel("vertical distance (m)");

% plot knee joint movement
figure
plot(B1, B2)
title("Movement of Knee joint");
xlabel("horizontal distance (m)");
ylabel("vertical distance (m)");

% plot ankle joint movement
figure
plot(C1, C2)
title("Movement of Ankle joint");
xlabel("horizontal distance (m)");
ylabel("vertical distance (m)");

% plot Toe joint movement
figure
plot(D1, D2)
title("Movement of Toe joint");
xlabel("horizontal distance (m)");
ylabel("vertical distance (m)");

% 3.b
% plot each joint movement in one figure
figure
plot(A1, A2, 'DisplayName', "Hip");
hold on;
plot(B1, B2, 'DisplayName', "Knee");
plot(C1, C2, 'DisplayName', "Ankle");
plot(D1, D2, 'DisplayName', "Toe");
hold off;
axis([0 3 0 1.4])
title("Movement of Each joint During Motion");
xlabel("horizontal distance (m)");
ylabel("vertical distance (m)");
legend;

figure
% 3.c
% generates an animation of step movement
set(groot,'defaultLineLineWidth',1);
for i = 1:243 % data length

    % A1,2 hip(x,y)
    % B1,2 knee(x,y)
    % C1,2 ankle(x,y)
    % D1,2 toe(x,y)
    
    plot([A1(i,1) B1(i,1)], [A2(i,1) B2(i,1)], 'r', ...
         [B1(i,1) C1(i,1)], [B2(i,1) C2(i,1)], 'g', ...
         [C1(i,1) D1(i,1)], [C2(i,1) D2(i,1)], 'b');
        axis([0 2.75 0 1.4]); % axis range
   title("Motion of Right Leg for one Stride");
        hold on;
        drawnow
end

% 3.d
% identify stance and swing phase, identified via Tracking Software
% duration of one gait cycle in seconds
gaitCycleTotal = 1.858 - 0.608;
% stance phase - heel strike to toe off
stancePhaseSeconds = abs(0.608 - 1.417);
stancePhasePercent = (stancePhaseSeconds / gaitCycleTotal) * 100;
disp("Stance Phase: " + stancePhaseSeconds + "s, " + stancePhasePercent + "%")
% swing phase - toe off to heel strike
swingPhaseSeconds = abs(1.418 - 1.858);
swingPhasePercent = (swingPhaseSeconds / gaitCycleTotal) * 100;
disp("Swing Phase: " + swingPhaseSeconds + "s, " + swingPhasePercent + "%")

% 3.e
% calc stride length, distance between corresponding points on same foot
strideLength = C1(160,1) - C1(30,1);
disp("stride length: " + strideLength + " meters")

% calculate step length, distance between corresponding points on opposite
% feet
stepLength = strideLength / 2;
disp("step length: " + stepLength + " meters")

% calculate cadence in steps per minute
% using time measurements from Tracking software, one step started at 0.6s
% and ended at 1.275s
stepTimeSeconds = 1.275 - 0.6;
% 1 second is equal to 0.0167 minutes
cadence = (1 / stepTimeSeconds) / 0.0167;
disp("cadence: " + cadence + " steps per minute")

% calculate average velocity
% avg velocity was calculated using distance covered by HIP joint over the
% the time of the step
distance = A1(243,1) - A1(119,1);
time = 1.975 - 0.95;
averageVelocity = distance / time;
disp("average velocity: " + averageVelocity + " meters per second")

