function [ dP ] = dP2waves( z, P, sep, sap, ses, sas, N, wavelengthP, wavelengthS, tau, Aeff, Gmm )
dP = zeros(2, 1);
N2 = N22waves(P, sep, sap, ses, sas, N, wavelengthP, wavelengthS, tau, Aeff, Gmm);
N1 = N - N2;
dP(1) = Gmm*P(1)*(sep*N2 - sap*N1);
dP(2) = P(2)*(ses*N2 - sas*N1);
end