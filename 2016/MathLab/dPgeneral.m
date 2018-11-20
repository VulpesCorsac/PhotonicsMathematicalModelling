function [ dP ] = dPgeneral ( z, P, sectionsEmission, sectionsAbsorbtion, N, wavelengths, tau, Aeff, Gmm )
N2 = N2general(P, sectionsEmission, sectionsAbsorbtion, N, wavelengths, tau, Aeff, Gmm);
N1 = N - N2;
P(1) = P(1)*Gmm;
dP = P.*((sectionsEmission)'*N2-(sectionsAbsorbtion)'*N1);
end