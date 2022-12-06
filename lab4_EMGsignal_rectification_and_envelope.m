%{
FFT Method 
%}
fe = 1000;
N = size(emgSignal,1);
dt = 1/fe;
t = 0:dt:(N-1)*dt;

PH2 = (fft(emgSignal));

P2 = (PH2/N);
P1 = (P2(1:N/2+1));
P1(2:end-1) = 2*P1(2:end-1);
f = fe*(0:(N/2))/N;

figure(1);
plot(f,abs(P1))
title('Frequency Domain')
xlabel('f(HZ)')
ylabel('|P1(f)|')


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

figure(2);
plot(emgSignal)
title('Raw EMG Signal')
xlabel('Time (s)');
ylabel('Amplitude (V)');

figure(3);
plot(rectSignal)
title('Rectified EMG Signal')
xlabel('Time (s)');
ylabel('Amplitude (V)');

%{
Envelope
%}
time = 1:4782;
window = 150;
iterations = round(length(rectSignal)/window);


clusteredData = zeros(2,iterations);
for i = 1:iterations-1
    avg = rms(rectSignal((i-1)*window+1:(i-1)*window+window,1));
    clusteredData(1,i) = avg;
    clusteredData(2,i) = time(window/2 + window*(i-1));
end

avg = rms(rectSignal((iterations-1)*100+1:length(rectSignal),1));
clusteredData(1, iterations) = avg;
clusteredData(2, iterations) = time(window/2 + window*(iterations-1));


figure(4);
plot(clusteredData(2,:), clusteredData(1,:),'b');
hold on;
plot(rectSignal)
title('Rectified Signal with Envelope');
xlabel('Time (s)');
ylabel('Amplitude (V)');

%{
Generate Sound
%}
soundArr = zeros(4782:1);
for i = 1:4782
    if abs(emgSignal(i,:)) > 1
        soundArr(i,1) = emgSignal(i,:);
    else
        soundArr(i,1) = 0;
    end
end

soundsc(1000000*soundArr,1000);

