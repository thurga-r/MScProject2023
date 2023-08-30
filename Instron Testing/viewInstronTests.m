%% housekeeping

clear all;
clc;
close all;

%% import data

setPath = ["C:\Users\thurg\OneDrive\Documents\MSc Diss\Data\Instron Tests\Compiled"];   %path to data

samples = ["EF10","EF15","EF20","EF25","EF30","EF35","EF40","EF45","EF50","VF10","VF15","VF20","VF25","VF30","VF35","VF40","VF50","VF60"];  %sample names

DispTab = importTestDat(setPath, samples, 2);  %imports individual displacement data files into one table
ForceTab = importTestDat(setPath, samples, 3);  %imports individual force data files into one table

%% process

%convert tables into array
dispDat = table2array(DispTab);
forceDat = table2array(ForceTab);

%loop to identify non-zero start in displacements and zeroing them
for i = 1:18
    if dispDat(1,i) ~= 0
        nonzer = dispDat(1,i); %non-zero value identified
        dispDat(:,i) = dispDat(:,i) - nonzer; %subracted from all displacement values for that run
    end
end

%% plot

figure;
LoadDispPlot = tiledlayout('flow');

%loop to locate run data in each column of data variable
for i = 1:18
    count = 0; %counting variable
    %loops through all data points until it reaches zero value
    for j = 1:length(forceDat)
        if forceDat(j,i) ~= 0
            count = count + 1; %will obtain number of datapoints in the run
        else
            break
        end
    end

    %isolates the run data
    x = dispDat(1:count,i);   %for displacement
    y = forceDat(1:count,i);    %for force

    %plots load displacement for a sample run
    nexttile
    hold on
    plot(x,y, '-','LineWidth',1)  %plots
    title(samples(i))  %titles sample
    xlabel('Displacement (mm)')  %title of x-axis
    ylabel('Force (kN)')  %title of y-axis
    xlim([0,2.5])  %sets x range to show only useful part of curves
    xticks(0:0.5:2.5)
    grid on
    grid minor  %adds gridlines to plot
end
title(LoadDispPlot,'Load Displacement Plots')
fontsize(15,"points")

%% all together plot

figure;
selPlot = tiledlayout('flow');

nexttile;
%loop to locate run data in each column of data variable
for i = 1:18
    count = 0; %counting variable
    %loops through all data points until it reaches zero value
    for j = 1:length(forceDat)
        if forceDat(j,i) ~= 0
            count = count + 1; %will obtain number of datapoints in the run
        else
            break
        end
    end

    %isolates the run data
    x = dispDat(1:count,i);   %for displacement
    y = forceDat(1:count,i);    %for force

    %plots load displacement for a sample run
    hold on
    plot(x,y, '-','LineWidth',2)  %plots


end
xlabel('Displacement (mm)')  %title of x-axis
ylabel('Force (kN)')  %title of y-axis
xlim([0,2.5])  %sets x range to show only useful part of curves
grid on
grid minor  %adds gridlines to plot
title('with y-range between 0 and 30 kN')  %titles sample

nexttile;
%loop to locate run data in each column of data variable
for i = 1:18
    count = 0; %counting variable
    %loops through all data points until it reaches zero value
    for j = 1:length(forceDat)
        if forceDat(j,i) ~= 0
            count = count + 1; %will obtain number of datapoints in the run
        else
            break
        end
    end

    %isolates the run data
    x = dispDat(1:count,i);   %for displacement
    y = forceDat(1:count,i);    %for force

    %plots load displacement for a sample run
    hold on
    plot(x,y, '-','LineWidth',2)  %plots


end
xlabel('Displacement (mm)')  %title of x-axis
ylabel('Force (kN)')  %title of y-axis
xlim([0,2.5])  %sets x range to show only useful part of curves
ylim([0,2])
grid on
grid minor  %adds gridlines to plot
title('with y-range between 0 and 2 kN')  %titles sample

title(selPlot,'Load Displacement Plots')
lgd = legend(samples);
lgd.Layout.Tile = 'east';
fontsize(15,"points")
