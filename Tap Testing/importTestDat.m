function setNam = importTestDat(setPath, colNam, varargin);
%%

%Function: Compiles all the voltage (or other variable data if optional
%input is used) from a set of tests into a table
% from a folder path

%Inputs: setPath  (file path to the folder with data txt files)
%        colNam   (variable containing column names) varargin (Allow extra
%        input in the case different column is to be imported, extra input
%        value would specify column number to import)

%Outputs: setNam (variable containing each test run in a separate column)

%%

files = dir(setPath) ;    %get all text files of the folder
N = length(files) ;      %total number of files

numRec = 0;   %buffer variable

%loop for each file to find max datapoint length
for i = 3:N
    thisfile = fullfile(setPath, files(i).name);    %present file
    %find max rows needed for set of data
    volCol = impCol(thisfile);
    if numRec < length(volCol)
        numRec = length(volCol);
    end
end

setNam = table('Size', [0, 0]);  %initialises table

%loop for each file
for i = 3:N
    buffer = zeros(numRec,1); %initialise buffer to make sure data is all the same length
    thisfile = fullfile(setPath, files(i).name);    %present file

    %switch statement to identify if more than one column needs to be
    %imported
    switch nargin
        case 2
            buffer(1:length(impCol(thisfile))) = impCol(thisfile);  %imports data to buffer
        case 3
            buffer(1:length(impCol(thisfile))) = impCol(thisfile, varargin{1});  %imports data to buffer
    end
    setNam = addvars(setNam, buffer, 'NewVariableNames', colNam(i-2));  %adds data as a column to table
end

end
