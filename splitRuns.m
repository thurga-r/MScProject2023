function matnam = splitRuns(setNam,numTap,k)
%%

%Function: Splits up the repeats in a run of data into separate columns of
%a single variable and denoises them

%Inputs: setNam  (variable containing one run of tap test data)
%        numTap  (number of taps in the run of the test) k       (interval
%        of each tap)

%Outputs: matnam (variable containing each tap in a separate column)

%%

matnam = zeros(k,numTap);  %initialises output variable

%loop to separate one run into numTap taps
for i = 1:numTap
    if i == 1
        matnam(:,i) = setNam(1:k);  %separates
        matnam = wdenoise(matnam, 10, NoiseEstimate="LevelDependent");  %denoises
    else
        matnam(:,i) = setNam(((k*(i-1))+(1025*(i-1))+1:(k*i)+(1025*(i-1))));  %separates
        matnam = wdenoise(matnam, 10, NoiseEstimate="LevelDependent");  %denoises
    end
end