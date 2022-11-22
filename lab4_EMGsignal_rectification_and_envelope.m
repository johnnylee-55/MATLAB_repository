%{
Rectification
%}

rectSignal = zeros(4782,1);
emgSignal = zeros(4782,1);

for i = 1:4782
    % adjusted so that baseline is set to zero
    emgSignal(i,:) = johnnyEMG(i,:) - 1.5;
end

for i = 1:4782
    if (emgSignal(i,:) >= 0)
        rectSignal(i,:) = emgSignal(i,:);
    else
        rectSignal(i,:) = -emgSignal(i,:);
    end
end

subplot(1,2,1)
plot(emgSignal)
title('Raw EMG Signal')

subplot(1,2,2)
plot(rectSignal)
title('Rectified EMG Signal')
