clc

set(groot,'defaultLineLineWidth',1);
for i = 1:243 %data length
    
    plot([A1(i,1) B1(i,1)], [A2(i,1) B2(i,1)], 'r', ...
         [B1(i,1) C1(i,1)], [B2(i,1) C2(i,1)], 'g', ...
         [C1(i,1) D1(i,1)], [C2(i,1) D2(i,1)], 'b');
        axis([0 2.75 0 1.4]); %axis range
        hold on;
        drawnow
end
