%% housekeeping

clear all;
clc;
close all;

%% import and view data

setPath = ["C:\Users\thurg\OneDrive\Documents\MSc Diss\Data\Linearity Tests\1608\TR - dataset"];   %path to data
files = dir(setPath) ;    %get all text files of the folder
N = length(files) ;      %total number of files


figure; %for force
linearityTestsForce = tiledlayout('flow');

for i = 3:N
    buffer = cleanFGdat(setPath, files(i));
    nexttile
    hold on
    plot(buffer(:,2))  %plots
    title(i-2)  %titles each run
    xlabel('Time point')  %title of x-axis
    ylabel('Force (N)')  %title of y-axis
    xlim([0,1000])  %sets x range
    ylim([0,15])  %set y range
    grid on
    grid minor  %adds gridlines to plot
end
title(linearityTestsForce,'Linearity Tests: Force')

figure; %for voltage
linearityTestsVol = tiledlayout('flow');

for i = 3:N
    buffer = cleanFGdat(setPath, files(i));
    nexttile
    hold on
    plot(buffer(:,1))  %plots
    title(i-2)  %titles each run
    xlabel('Time point')  %title of x-axis
    ylabel('Voltage (V)')  %title of y-axis
    xlim([0,1000])  %sets x range
    ylim([0.5,3.5])  %set y range
    grid on
    grid minor  %adds gridlines to plot
end
title(linearityTestsVol,'Linearity Tests: Voltage')

%}

%% import, splice and plot data

timRang = 600;

runVol = zeros(timRang,N-2);  %initialises voltage variable
runForce = zeros(timRang,N-2);  %initialises force variable
runDisp = zeros(timRang,N-2);  %initialises displacement variable

for i = 3:N
    buffer = cleanFGdat(setPath, files(i));
    count = 0;
    for j = 1:length(buffer)
        if buffer(j,2)<0.1
            count = count + 1;
        end
    end
    runForce(:,i-2) = buffer(count:(count+timRang-1),2);
    runVol(:,i-2) = buffer(count:(count+timRang-1),1);
    runDisp(:,i-2) = buffer(count:(count+timRang-1),3);
end

figure; %for force
splicedLTForce = tiledlayout('flow');

for i = 3:N
    nexttile
    hold on
    plot(runForce(:,i-2))  %plots
    title(i-2)  %titles each run
    xlabel('Time point')  %title of x-axis
    ylabel('Force (N)')  %title of y-axis
    xlim([0,timRang])  %sets x range
    ylim([0,15])  %set y range
    grid on
    grid minor  %adds gridlines to plot
end
title(splicedLTForce,'Linearity Tests: Force')

figure; %for voltage
splicedLTVol = tiledlayout('flow');

for i = 3:N
    nexttile
    hold on
    plot(runVol(:,i-2))  %plots
    title(i-2)  %titles each run
    xlabel('Time point')  %title of x-axis
    ylabel('Voltage (V)')  %title of y-axis
    xlim([0,timRang])  %sets x range
    ylim([0.5,3.5])  %set y range
    grid on
    grid minor  %adds gridlines to plot
end
title(splicedLTVol,'Linearity Tests: Voltage')

%}

%% process linearity

intYDat = zeros(N-2,timRang);   %initialises relative voltage variable

%loop to work out relative voltage for dataset
for i = 1:N-2
    for j = 1:timRang
        intYDat(i,j) = (runVol(j,i)-min(runVol(:,i)))/min(runVol(:,i));
    end
end

yData = mean(intYDat);   %mean relative voltage for each time point
xData = mean(transpose(runForce));   %x-axis data points

%line of best fit
coefficients = polyfit(xData, yData, 1);   %finds coefficients for line
xFit = linspace(min(xData), max(xData), 600);   %creates x values
yFit = polyval(coefficients , xFit);   %creates y values using coefficients


%% plot linearity

figure;

plot(xData,yData, '*','MarkerSize',5)   %plots mean relative voltage change
hold on
plot(xFit, yFit, 'k', 'LineWidth',2)   %plots line of best fit
title('Linearity Plot')
xlabel('Force (N)')  %title of x-axis
ylabel('Relative Voltage')  %title of y-axis
xlim([0,13])
ylim([0,3.2])
legend('Data','Linear Line')
grid on
grid minor  %adds gridlines to plot
fontsize(15,"points")

%% plot selective data

plotthis = [1,6,11,16,21,26,31];

figure;
selPlot = tiledlayout('flow');

nexttile;
for i = plotthis
    hold on
    plot(runForce(:,i), 'LineWidth',2)  %plots
end
title('Force Data')
xlabel('Time point')  %title of x-axis
ylabel('Force (N)')  %title of y-axis
xlim([0,timRang])  %sets x range
ylim([0,16])  %set y range
grid on
grid minor  %adds gridlines to plot
fontsize(15,"points")

nexttile;
for i = plotthis
    hold on
    plot(runVol(:,i), 'LineWidth',2)  %plots
end
title('Voltage Data')
xlabel('Time point')  %title of x-axis
ylabel('Voltage (V)')  %title of y-axis
xlim([0,timRang])  %sets x range
ylim([0.5,3.5])  %set y range
grid on
grid minor  %adds gridlines to plot

%legend
lgd = legend('1','6', '11', '16', '21','26','31');
lgd.Layout.Tile = 'east';
title(lgd,'Run')

title(selPlot,'Individual Runs of Sensor Linearity Tests')
fontsize(15,"points")