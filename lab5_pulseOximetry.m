%% Peak Detection
fs = 128;

% filter data with lowpass
% infrared data is used here to find heart rate
infrared = lowpass(infrared, 20, fs);
flatSegment = infrared(2300:2852);

% peak detection function, defined at bottom of file
[peakVal, peakPos, peakIndex] = detectPeaks(flatSegment, 286000);

ppgPeaks = peakIndex - 1;


%% Heart Rate Value
index = 1;
for i = 1:ppgPeaks-1
    e(index) = peakPos(i+1)-peakPos(i);
    index = index + 1;
end
heartRate = (60./mean(e))*128;
heartRateValues = (60./e)*128;


%% SpO2
t = 1:1:553;
t2 = t/128;
t2 = t2';

% R-value constants
a = -16.666667;
b = 8.333333;
c = 100;
% peak detection of PPG
red = lowpass(red, 20, fs);
redSegment = red(2300:2852);
infraredSegment = infrared(2300:2852);

DCred = rms(redSegment);
DCinfrared = rms(infraredSegment);


index = 1;
for i = 1:ppgPeaks-1
    e(index) = peakPos(i+1) - peakPos(i);
    index = index + 1;
end

% peak detection of red light
[redPeakVal, ACredPosition, AcredSignal] = detectACPeaks(redSegment, DCred);

% peak detection of infrared light
DCinfrared = DCinfrared + 1000; % +1000 for better peak detection
[infraPeakVal, ACinfraPosition, ACinfraSignal] = detectACPeaks(infraredSegment, DCinfrared);

% SpO2 calculation
for i = 1 : index
    R(i) = ((redPeakVal(i)-ACredSignal(i))/DCred)/((infraPeakVal(i)-ACinfraSignal(i))/DCinfrared);
    SpO2(i) = a*R(i)*R(i) + (b*R(i)) + c;
end

% plot functions
yyaxis left
plot(t2, redSegment); hold on; plot(t2, infraredSegment); hold on;
yyaxis right
plot(ACredPosition/128, SpO2);
axis([0 5 80 110])

%% Function Definitions
function [peakVal, peakPos, peakInd] = detectPeaks(array, threshold)
    peakInd = 1;
    n = length(array);
    for i = 2 : n-1
        if array(i) > array(i-1) && array(i) > array(i+1) && array(i) > threshold
            peakVal(peakInd) = array(i);
            peakPos(peakInd) = i;
            peakInd = peakInd + 1;
        end
    end
end

function [peakVal, peakPos, ACsignal] = detectACPeaks(array, DC)
    index = 1;
    n = length(array);
    for i=2:n-1
        if array(i)>array(i-1) && array(i)>=array(i+1) && array(i) > DC
            peakVal(index) = array(i);
            peakPos(index) = i;
            ACsignal(index) = array(peakPos(index)-25);
            index = index + 1;
        end
    end
end