
set(groot, 'defaultLineLineWidth', 1)
for i = 1 : 1151
    plot(i,redSegment);
    %axis([0 10 350000 370000]);
    hold on;
    drawnow
end