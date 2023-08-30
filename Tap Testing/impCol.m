function matnam = impCol(filename,varargin)
%%

%Function: Imports a column of data in (default is the second column
%containing voltage values, from tap tests data from the named file)

%Inputs: filename (String with the name of the file)
%        varargin (Allow extra input in the case different column is to be
%        imported, extra input value would specify column number to import)

%Outputs: matnam (Variable with one column data from specified file)

%%

%switch statement to run depending on whether there is one or two inputs
switch nargin
    case 1
        data = readmatrix(filename);   %reads in whole txt file into a matrix
        matnam = data(:,2);   %isolates second column
    case 2
        data = readmatrix(filename);   %reads in whole txt file into a matrix
        matnam = data(:,varargin{1});   %isolates relevant column
end

end

