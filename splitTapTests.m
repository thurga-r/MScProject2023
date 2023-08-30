%% housekeeping
clear;
clc;
close all;

%% import normalised rigid data and initialise

rNorm = readmatrix('RigidCompiledDataset.txt');

col = width(rNorm); %find number of columns/samples
count = 1;   %counting variable initialised
intl = 55000;   %set tap interval

%% split into samples and denoise

%each variable has single taps in separate columns

ef10 = splitRuns(rNorm(:,count),30, intl); count=count+1;
ef15 = splitRuns(rNorm(:,count),30, intl); count=count+1;
ef20 = splitRuns(rNorm(:,count),30, intl); count=count+1;
ef25 = splitRuns(rNorm(:,count),30, intl); count=count+1;
ef30 = splitRuns(rNorm(:,count),30, intl); count=count+1;
ef35 = splitRuns(rNorm(:,count),30, intl); count=count+1;
ef40 = splitRuns(rNorm(:,count),30, intl); count=count+1;
ef45 = splitRuns(rNorm(:,count),30, intl); count=count+1;
ef50 = splitRuns(rNorm(:,count),30, intl); count=count+1;

vf10 = splitRuns(rNorm(:,count),30, intl); count=count+1;
vf15 = splitRuns(rNorm(:,count),30, intl); count=count+1;
vf20 = splitRuns(rNorm(:,count),30, intl); count=count+1;
vf25 = splitRuns(rNorm(:,count),30, intl); count=count+1;
vf30 = splitRuns(rNorm(:,count),30, intl); count=count+1;
vf35 = splitRuns(rNorm(:,count),30, intl); count=count+1;
vf40 = splitRuns(rNorm(:,count),30, intl); count=count+1;
vf50 = splitRuns(rNorm(:,count),30, intl); count=count+1;
vf60 = splitRuns(rNorm(:,count),30, intl);

%% view by plotting

samples = ["EF10","EF15","EF20","EF25","EF30","EF35","EF40","EF45","EF50","VF10","VF15","VF20","VF25","VF30","VF35","VF40","VF50","VF60"];  %sample names

count = 1;   %counting variable reinitialised

plotRuns(ef10,30, samples(count)); count=count+1;
plotRuns(ef15,30, samples(count)); count=count+1;
plotRuns(ef20,30, samples(count)); count=count+1;
plotRuns(ef25,30, samples(count)); count=count+1;
plotRuns(ef30,30, samples(count)); count=count+1;
plotRuns(ef35,30, samples(count));count=count+1;
plotRuns(ef40,30, samples(count)); count=count+1;
plotRuns(ef45,30, samples(count)); count=count+1;
plotRuns(ef50,30, samples(count)); count=count+1;

plotRuns(vf10,30, samples(count));count=count+1;
plotRuns(vf15,30, samples(count)); count=count+1;
plotRuns(vf20,30, samples(count)); count=count+1;
plotRuns(vf25,30, samples(count)); count=count+1;
plotRuns(vf30,30, samples(count)); count=count+1;
plotRuns(vf35,30, samples(count));count=count+1;
plotRuns(vf40,30, samples(count)); count=count+1;
plotRuns(vf50,30, samples(count)); count=count+1;
plotRuns(vf60,30, samples(count));

%% view one tap


j=5;   %isolate the 5th tap
k=55000;   %interval set above
fifthTap = zeros(k,18);   %initialise variable to hold tap 5 data for each sample

figure;
secTap = tiledlayout('flow');   %create the plot
%loop to obtain and plot each samples tap 5 signal
for i = 1:18
    matnam = rNorm(((k*(j-1))+(1025*(j-1))+1:(j*k)+(1025*(j-1))),i);  %separates
    matnam = wdenoise(matnam, 10, NoiseEstimate="LevelDependent");  %denoises
    fifthTap(:,i) = matnam;  %assigns tap 5 signal to respective column in variable
    nexttile
    hold on
    plot(matnam)  %plots
    title(samples(i))
    xlim([0,55000])
    yticks(0:0.25:1)
    ylim([0,1])
    grid on
    grid minor
end
title(secTap,'Sensor Readings for a Single Tap with Rigid Phantom')
fontsize(15,"points")


%% approximate slopes

upX = 24000;  %sets upper x value
lowXV = 16000;   %lower x value for vf samples
lowXE = 16000;   %lower x value for ef samples

upY = fifthTap(upX, 1:18);   %corresponding upper y values found
lowYV = fifthTap(lowXV, 10:18);   %corresponding lower y values found for vf
lowYE = fifthTap(lowXE, 1:9);   %corresponding lower y values found for ef


slopeV = (upY(10:18)-lowYV)/(upX-lowXV);   %slope for vf calculated
slopeE = (upY(1:9)-lowYE)/(upX-lowXE);   %slope for ef calculated


slopex = categorical(samples);   %x-axis or bar graph
slopey = [slopeE, slopeV];   %joins values ef and vf into one

%plots bar graph
figure;
bar(slopex,slopey)
title('Approximate Slope Values for Samples in Rigid Dataset')
xlabel('Samples')
ylabel('Slope')
grid on
grid minor  %adds gridlines to plot
fontsize(15,"points")