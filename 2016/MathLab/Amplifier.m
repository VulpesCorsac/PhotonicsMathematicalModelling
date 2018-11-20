%% Инициализация данных
CrossSectionsAllData = xlsread('CrossSection.xls');
wavelengthArray = CrossSectionsAllData(:,9);
sectionEmissionArray = CrossSectionsAllData(:,12);
sectionAbsorbtionArray = CrossSectionsAllData(:,13);
%% Задание основных констант в системе СИ
length = 0.5;
lightSpeed = 3E8;
N = 4000*6.62E22;
dCore = 6E-6;
dCladding = 125E-6;
Gmm = dCore^2 / 2 / dCladding^2;
tau = 1.54E-3;
Aeff = pi  * dCore^2 / 4;
%% Решение в случае одной волны накачки и одной сигнальной волны
% wavelengthPump = 975;
% wavelengthSignal = 1100;
% sectionEmissionPump = interp1(wavelengthArray, sectionEmissionArray, wavelengthPump);
% sectionAbsorbtionPump = interp1(wavelengthArray, sectionAbsorbtionArray, wavelengthPump);
% sectionEmissionSignal = interp1(wavelengthArray, sectionEmissionArray, wavelengthSignal);
% sectionAbsorbtionSignal = interp1(wavelengthArray, sectionAbsorbtionArray, wavelengthSignal);
% powerPump = 0.6;
% powerSignal = 0.001;
% 
% options = odeset('RelTol',1e-4,'AbsTol',[1e-5 1e-5]);
% [z, P] = ode45(@dP2waves, [0 length], [powerPump powerSignal], options, sectionEmissionPump, sectionAbsorbtionPump, sectionEmissionSignal, sectionAbsorbtionSignal, N, wavelengthPump, wavelengthSignal, tau, Aeff, Gmm);
% 
% sizeZ = size(z);
% lengthZ = sizeZ(1);
% 
% plot(z, P);
% 
% Gain = 10*log10(P(lengthZ,2)/P(1,2));
% 
% sizeZ = size(z);
% lengthZ = sizeZ(1);
% N2 = zeros(lengthZ);
% 
% for i = 1:lengthZ
% N2(i) = N22waves(P(i,:), sectionEmissionPump, sectionAbsorbtionPump, sectionEmissionSignal, sectionAbsorbtionSignal, N, wavelengthPump, wavelengthSignal, tau, Aeff, Gmm)*100/N;
% end
% plot(z, N2);
%% Решение в случае множества длин волн
wavelengths = [975];
powers = [0.7];

spectrumWavelengthMin = 1027;
spectrumWavelengthMax = 1033;
spectrumWavelengthAmmout = 3;
spectrumPower = 0.001;
[spectrumWavelengths , spectrumPower] = Spectrum(spectrumPower, spectrumWavelengthMin, spectrumWavelengthMax, spectrumWavelengthAmmout);

wavelengths = horzcat(wavelengths, spectrumWavelengths);
powers = horzcat(powers, spectrumPower);

sectionsEmission = interp1(wavelengthArray, sectionEmissionArray, wavelengths);
sectionsAbsorbtion = interp1(wavelengthArray, sectionAbsorbtionArray, wavelengths);

options = odeset('RelTol', 1e-4, 'AbsTol', 1e-5);
[ z, P ] = ode45(@dPgeneral, [0 length], powers, options, sectionsEmission, sectionsAbsorbtion, N, wavelengths, tau, Aeff, Gmm);

plot(z, P);

sizeZ = size(z);
lengthZ = sizeZ(1);

N2 = zeros(1,lengthZ);
for i = 1:lengthZ
    P(i,1) = P(i,1)*Gmm;
    N2(i) = N2general((P(i,:))', sectionsEmission, sectionsAbsorbtion, N, wavelengths, tau, Aeff, Gmm)*100/N;
end

figure;
plot(z, N2);

PStart = P(1,2:spectrumWavelengthAmmout+1);
PFinish = P(lengthZ,2:spectrumWavelengthAmmout+1);
amplifiedSpectrum = transpose([PStart;PFinish]);

%PoutSpectral = @(x) interp1(spectrumWavelengths, PFinish, x);
%Pout1 = integral(PoutSpectral,spectrumWavelengthMin,spectrumWavelengthMax)
Pout2 = sum(PFinish);
Gain = 10*log10(PFinish./PStart);

figure;
plot(spectrumWavelengths, Gain);
%ylim([0 25]);
