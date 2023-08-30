function testrun = cleanFGdat(setPath, file)
%%

%Function: Processes and cleans the data from one run of a force gauge
%progressive compression test

%Inputs: setPath  (file path to the folder with data txt files)
%        file     (name of the file in the folder)

%Outputs: testrun (variable containing the the voltage, force and
%displacement data)

%%

thisfile = fullfile(setPath, file.name);    %present file
data = readmatrix(thisfile);   %reads in whole txt file into a matrix
count = 0;  %initialises counting variable
num = length(data);   %number of datapoints

%loop to find how many non-zero datapoints there are
for i = 1:num
       if data(i,3) > 0
            count = count + 1;
        end
end

buffer = zeros(count,3);   %initialise buffer variable
count2 = 1;  %initialises second counting variable

%loop for assigning each column of non-zero datapoints to the relevant
%buffer column
for j = 1:num
    if data(j,3) > 0
        buffer(count2,1) = data(j,2); %column for voltage data
        buffer(count2,2) = data(j,3); %column for force data
        buffer(count2,3) = data(j,4); %column for displacement data
        count2 = count2 + 1;
    end
end

count3 = 0;   %initiailises third counting variable

%loop for identifying point at which force gauge indenter hits the sensor
for k = 1:count
    if buffer(k,2) ~= 0.01
        count3 = count3 + 1;
    else
        break
    end
end

testrun = buffer((count3+1):end,:);   %assigns relevant data to the export variable

end
