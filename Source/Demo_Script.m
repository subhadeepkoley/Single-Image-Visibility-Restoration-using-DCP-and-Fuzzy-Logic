close all; clear; clc;

% Read the input image
img = im2double(imread('canon.jpg'));

% Perform DCP dehazing
dehazedImg = imreducehaze(img, 0.95,...
    'Method', 'approxdcp',...
    'ContrastEnhancement', 'none');

% Fuzzy contrast enhancement
% Define input membership functions
uDark = @(z)gaussmf(z, [0.15, 0.2]);
uGray = @(z)gaussmf(z, [0.15, 0.5]);
uBright = @(z)gaussmf(z, [0.15, 0.8]);

% Plot the input membership functions
figure
hold on
fplot(uDark, [0 1], 20)
fplot(uGray, [0 1], 20)
fplot(uBright, [0 1], 20)
hold off
box on
grid on
title('Input Membership Functions')

% Define output membership functions
uDarker = @(z)bellmf(z, 0.0, 0.1);
uMidGray = @(z)bellmf(z, 0.4, 0.5);
uBrighter = @(z)bellmf(z, 0.8, 0.9);

% Plot the output membership functions
figure
hold on
fplot(uDarker, [0 1], 20)
fplot(uMidGray, [0 1], 20)
fplot(uBrighter, [0 1], 20)
hold off
box on
grid on
title('Output Membership Functions')

% Obtain fuzzy system response function
rules = {uDark; uGray; uBright};
outMF = {uDarker, uMidGray, uBrighter};
F = fuzzysysfcn(rules, outMF, [0 1]);

% Use fuzzy system response function to construct an intensity
% transformation function
z = linspace(0, 1, 256);
T = F(z);

% Apply the intensity transformation function
redChannel = specfiedTransform(dehazedImg(:, :, 1), T);
greenChannel = specfiedTransform(dehazedImg(:, :, 2), T);
blueChannel = specfiedTransform(dehazedImg(:, :, 3), T);
result = cat(3, redChannel, greenChannel, blueChannel);
result = result.*1.2;

figure
imshow([img, dehazedImg, result])
title('Input Hazy Image    |   Dehazed Image     |    Final Contrast Enhanced Image')