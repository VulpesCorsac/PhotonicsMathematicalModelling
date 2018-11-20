function [ N2 ] = N2general ( P, sectionsEmission, sectionsAbsorbtion, N, wavelengths, tau, Aeff, Gmm )
P(1) = P(1)*Gmm;
rho = (P.*(wavelengths')) / Aeff / (1240 * 1.6E-19);
N2 = N * (sectionsAbsorbtion*rho)/ ((sectionsAbsorbtion+sectionsEmission)*rho + 1/tau);
end