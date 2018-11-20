function [ wavelength, power ] = Spectrum( integralPower, wavelengthMin, wavelengthMax, wavelengthAmmount )
wavelengthStep = (wavelengthMax-wavelengthMin)/(wavelengthAmmount-1);
wavelength = wavelengthMin:wavelengthStep:wavelengthMax;
spectralPower = integralPower/wavelengthAmmount;
power = ones(1,wavelengthAmmount).*spectralPower;
end