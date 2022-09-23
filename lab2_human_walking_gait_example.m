%read data from excel sheet
data = xlsread('lab2data.xlsx');

%assign columns to variables
time = data(:,1);
x_hip = data(:,2);
y_hip = data(:,3);
x_knee = data(:,6);
y_knee = data(:,7);
x_ank = data(:,10);
y_ank = data(:,11);
x_toe = data(:,14);
y_toe = data(:,15);

%calc for stride length
stride_length = (abs(x_ank(50)-x_ank(1)));
disp("Stride length: "+stride_length+" m");

%calc for step length
step_length=abs(stride_length/2);
disp("Step length: "+step_length+" m");

%calc for cadence
cadence = 1/(time(50)/60)*2;
disp("Cadence: "+cadence+" steps/min");

%calc for velocity
avg_velocity = step_length*cadence;
disp("Average velocity: "+avg_velocity+" m/min");

%hip plots
subplot(2,2,1)
grid
hold on
title('Hip Tracking Results (X)')
xlabel('Time (s)')
ylabel('X-Axis Hip Data Points (m)')
plot(time, x_hip, 'or','MarkerSize',1);

subplot(2,2,3)
grid
hold on
title('Hip Tracking Results (Y)')
xlabel('Time (s)')
ylabel('Y-Axis Hip Data Points (m)')
plot(time, y_hip, 'or','MarkerSize',1);

%knee plots
subplot(2,2,2);
grid
hold on
title('Knee Tracking Results (X)')
xlabel('Time (s)')
ylabel('X-Axis Knee Data Points (m)')
plot(time, x_knee, 'or','MarkerSize',1);

subplot(2,2,4);
grid
hold on
title('Knee Tracking Results (Y)')
xlabel('Time (s)')
ylabel('Y-Axis Knee Data Points (m)')
plot(time, y_knee, 'or','MarkerSize',1);

%ankle plots
figure()
subplot(2,2,1)
grid
hold on
title('Ankle Tracking Results (X)')
xlabel('Time (s)')
ylabel('X-Axis Ankle Data Points (m)')
plot(time, x_ank, 'or','MarkerSize',1);

subplot(2,2,3)
grid
hold on
title('Ankle Tracking Results (Y)')
xlabel('Time (s)')
ylabel('Y-Axis Ankle Data Points (m)')
plot(time, y_ank, 'or','MarkerSize',1);

%toe plots
subplot(2,2,2)
grid
hold on
title('Toe Tracking Results (X)')
xlabel('Time (s)')
ylabel('X-Axis Toe Data Points (m)')
plot(time, x_toe, 'or','MarkerSize',1);

subplot(2,2,4)
grid
hold on
title('Toe Tracking Results (Y)')
xlabel('Time (s)')
ylabel('Y-Axis Toe Data Points (m)')
plot(time, y_toe, 'or','MarkerSize',1);

%animation
figure()
set(groot,'defaultLineLineWidth',1)
for i=1:50
    a=x_hip(i,1)-x_hip(1,1);
    plot([x_hip(i,1)-a x_knee(i,1)-a],[y_hip(i,1) y_knee(i,1)],'m',[x_knee(i,1)-a x_ank(i,1)-a],[y_knee(i,1) y_ank(i,1)],'c',[x_ank(i,1)-a x_toe(i,1)-a],[y_ank(i,1) y_toe(i,1)],'g');
    axis([-1 1 -1.5 0]);
    drawnow
    
end
set(groot,'defaultLineLineWidth',1)
for i=1:50
    plot([x_hip(i,1) x_knee(i,1)],[y_hip(i,1) y_knee(i,1)],'m',[x_knee(i,1) x_ank(i,1)],[y_knee(i,1) y_ank(i,1)],'c',[x_ank(i,1) x_toe(i,1)],[y_ank(i,1) y_toe(i,1)],'g');
    axis([-2 0.5 -1.5 0]);
    hold on
    drawnow
end