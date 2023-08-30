function plotRuns(setNam,numTap,sampNam)
%%

%Function: Plots the repeats in a run of data

%Inputs: setNam  (variable containing one run of tap test data)
%        numTap  (number of taps in the run of the test) k       (interval
%        of each tap)

%Outputs: plot

%%

figure;
SplitDat = tiledlayout('flow');

%loop to plot each column of data
for i = 1:numTap
    nexttile
    hold on
    plot(setNam(:,i))
    title(i)
    xlim([0,55000])
    ylim([0,1])
    xlabel('Time point')  %title of x-axis
    ylabel('Voltage (V)')  %title of y-axis
    grid on
    grid minor
end
title(SplitDat,sampNam)
end
