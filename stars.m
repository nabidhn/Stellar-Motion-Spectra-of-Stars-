%% Compare Stellar Spectra
% This script analyzes stellar spectral data to determine motion
% relative to Earth using Doppler shift analysis.

%% Load data from previous project
load starData

%% Calculate Doppler shift
[sHa, idx] = min(spectra);
lambdaHa = lambda(idx);
z = lambdaHa / 656.28 - 1;
speed = z * 299792.458; % km/s

%%  Generate full wavelength vector
lambdaEnd = lambdaStart + (nObs - 1) * lambdaDelta;
lambda = (lambdaStart:lambdaDelta:lambdaEnd)';

%% Select star 2 for analysis
s = spectra(:, 2);

%%  - Plot intensity vs. wavelength
figure;
loglog(lambda, s, '.-');
xlabel("Wavelength");
ylabel("Intensity");

%%  Find H-alpha minimum
[sHa, idx] = min(s);
lambdaHa = lambda(idx);

%%  Mark H-alpha line
hold on;
loglog(lambdaHa, sHa, "rs", 'MarkerSize', 8);
hold off;

%% Calculate redshift and velocity
z = lambdaHa / 656.28 - 1;
speed = z * 299792.458; % km/s




%% - Plot spectra and highlight red/blue shifts
figure;
for c = 1:7
    s = spectra(:, c);
    if speed(c) <= 0
        loglog(lambda, s, "--")  % Blue shift
    else
        loglog(lambda, s, 'LineWidth', 3)  % Red shift
    end
    hold on
end
hold off

%% Add legend
legend(starnames)

%% Identify stars moving away from Earth
movaway = starnames(speed > 0)

%%  Stellar Motion
% Load data and parameters
load starData
nObs = size(spectra, 1);
lambdaStart = 630.02;
lambdaDelta = 0.14;

