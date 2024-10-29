% −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
% Visualization and descriptive statistics and plots for GDP growth in
% Sweden
% −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
% Lena Lengenfelder
% Version 1; 29 October 2024
% Data Source: https://fred.stlouisfed.org/series/CLVMNACSCAB1GQSE
% −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

%% Housekeeping
clearvars; clc;close all;

%% Import data (using the 'Import data' functionality)
% Import data from text file
% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["DATE", "DATA"];
opts.VariableTypes = ["datetime", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd", "DatetimeFormat", "preserveinput");

% Import the data
SwedenGDP = readtable("C:\Users\lenal\OneDrive\Dokumente\Data Science in Business and Economics\3. Semester\E436 Quantitative Macroeconomics\SwedenGDP.csv", opts);

% Clear temporary variables
clear opts

% Change date format (as quarterly data and day and month is not relevant)
SwedenGDP.DATE.Format = 'yyyy−QQQ';

%% Computations
gdp = SwedenGDP.DATA;
dates = SwedenGDP.DATE;

%% Visualization 
% Note: I only do the visualization part for the whole sample here
% Calculate quarterly growth rate as the percentage change between quarters
gdp_growth = (gdp(2:end) - gdp(1:end-1)) ./ gdp(1:end-1);
dates_growth = dates(2:end);  % Adjust dates to match growth rate

%% Task 1: Plot of Q-on-Q growth in Sweden
figure;
plot(dates_growth, gdp_growth);
title('Plot of Q-on-Q growth in Sweden');
xlabel('Date');
ylabel('Quarterly Growth Rate');
grid on

%% Task 2: Histogram of Q-on-Q growth in Sweden
figure;
subplot(1,2,1);
histfit(gdp_growth, 10, 'normal'); % Histogram with 10 bins, using histfit and 'normal ' adds fitted normal distribution line
xlabel('Growth Rate');
ylabel('Frequency');
hold on

subplot(1,2,2);
histfit(gdp_growth, 30, 'normal'); % Histogram with 30 bins
xlabel('Growth Rate');
ylabel('Frequency');
hold on

sgtitle('Histogram of Q−on−Q growth in Sweden'); % Add common figure title
hold off;

%% Task 3: Q-Q plot (Normal probability plot)
figure;
qqplot(gdp_growth);
title('Normal probability plot')

%% Task 4: Boxplot
figure;
boxplot(gdp_growth);
title('Boxplot');
ylabel('Quarterly Growth Rate')

%% Task 5: Numerical Output
% Numerical estimates for mean and standard deviation of the growth rate
avg_growth = mean(gdp_growth, 'omitnan');
std_growth = std(gdp_growth, 'omitnan');

fprintf('Average Quarterly Growth Rate: %.4f\n', avg_growth);
fprintf('Standard Deviation of Quarterly Growth Rate: %.4f\n', std_growth);
