%% housekeeping
clear;
clc;
close all;

%% import data
samples = ["EF10","EF15","EF20","EF25","EF30","EF35","EF40","EF45","EF50","VF10","VF15","VF20","VF25","VF30","VF35","VF40","VF50","VF60"];  %sample names

rigiddataset = importTestDat(['C:\Users\thurg\OneDrive\Documents\MSc Diss\Data\Tap Tests Compiled Set\Rigid\Set 3 Finalised'], samples);  %imports individual rigid dataset files into one table

fingerdataset = importTestDat(['C:\Users\thurg\OneDrive\Documents\MSc Diss\Data\Tap Tests Compiled Set\Finger\Set 4 Finalised'], samples);  %imports individual finger dataset files into one table

%% normalise

ul = 1680000;  %isolate the 30 taps

normRigid = zeros(ul,18);  %initialise variable for normalised rigid dataset
normFinger = zeros(ul,18);  %initialise variable for normalised finger dataset

for i = 1:18
    normRigid(:,i) = rescale(table2array(rigiddataset([1:ul],i)));  %applies min max normalisation to rigid dataset
    normFinger(:,i) = rescale(table2array(fingerdataset([1:ul],i)));  %applies min max normalisation to finger dataset
end

%% plot normalised data

figure;  %for rigid dataset
rNormPlots = tiledlayout('flow');

for i = 1:18
    nexttile
    plot(normRigid(:,i))  %plots
    title(samples(i))  %titles each sample
    %xlabel('Time point')  %title of x-axis ylabel('Normalised Voltage')
    %%title of y-axis
    xlim([0,ul])  %sets x range
    xticks(0:250000:ul)  %number of intervals in x-axis
    ylim([0,1])  %set y range
    yticks(0:0.25:1)
    grid on
    grid minor  %adds gridlines to plot
end
title(rNormPlots,'Normalised Rigid Indenter Data')
fontsize(15,"points")


figure;  %for finger dataset
fNormPlots = tiledlayout('flow');

for i = 1:18
    nexttile
    plot(normFinger(:,i))  %plots
    title(samples(i))  %titles each tap
    %xlabel('Time point')  %title of x-axis ylabel('Normalised Voltage')
    %%title of y-axis
    xlim([0,ul])  %sets x range
    xticks(0:250000:ul)  %number of intervals in x-axis
    ylim([0,1])  %set y range
    yticks(0:0.25:1)
    grid on
    grid minor  %adds gridlines to plot
end
title(fNormPlots,'Normalised Finger Phantom Data')
fontsize(15,"points")

%% min, max and mean

rigidMMM = zeros(18,3);  %initialise min max mean variable for rigid
fingerMMM = zeros(18,3);  %initialise min max mean variable for finger

sem = zeros(18,2);


for i = 1:18
    %min calculated for both datasets
    rigidMMM(i,1) = min(normRigid(:,i));
    fingerMMM(i,1) = min(normFinger(:,i));
    %max calculated for both datasets
    rigidMMM(i,2) = max(normRigid(:,i));
    fingerMMM(i,2) = max(normFinger(:,i));
    %mean and standard error of mean calculated for both datasets
    rigidMMM(i,3) = mean(normRigid(:,i));
    sem(i,1) = std(normRigid(:,i))/sqrt(30);
    fingerMMM(i,3) = mean(normFinger(:,i));
    sem(i,2) = std(normFinger(:,i))/sqrt(30);
end

%% plot means

meanx = categorical(samples);  %sets sample names as categories


figure;
meanBars = tiledlayout('flow');  %sets up subplot

nexttile  %for rigid dataset
bar(meanx, rigidMMM(:,3))
hold on
er = errorbar(meanx, rigidMMM(:,3),sem(:,1),sem(:,1),'LineStyle','none')  %sem error bars plotted
er.Color = [0 0 0];

title('Mean Normalised Voltage for Samples in Rigid Dataset')
xlabel('Samples')
ylabel('Normalised Voltage')
grid on
grid minor  %adds gridlines to plot
hold off

nexttile  %for finger dataset
bar(meanx, fingerMMM(:,3))
hold on
er = errorbar(meanx, fingerMMM(:,3),sem(:,2),sem(:,2),'LineStyle','none')  %sem error bars plotted
er.Color = [0 0 0];

title('Mean Normalised Voltage for Samples in Finger Dataset')
xlabel('Samples')
ylabel('Normalised Voltage')
grid on
grid minor  %adds gridlines to plot
hold off

%% export to txt files
writematrix(normFinger,'FingerCompiledDataset.txt','Delimiter',' ');%exports table into text file
writematrix(normRigid,'RigidCompiledDataset.txt','Delimiter',' '); %exports table into text file

