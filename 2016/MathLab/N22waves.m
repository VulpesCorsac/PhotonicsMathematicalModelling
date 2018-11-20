function [ N2 ] = N22waves( P, sep, sap, ses, sas, N, wavelengthP, wavelengthS, tau, Aeff, Gmm )
rhoP = Gmm*P(1) / Aeff / (1240 / wavelengthP * 1.6E-19);
rhoS = P(2) / Aeff / (1240 / wavelengthS * 1.6E-19);
N2 = N * (rhoP*sap + rhoS*sas) / (rhoP*(sep+sap) + rhoS*(ses+sas) + 1/tau);
end