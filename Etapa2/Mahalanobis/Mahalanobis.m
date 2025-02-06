% 2.1.2.2 Clasificación basada en distancia de Mahalanobis

clear, clc, close all

addpath("..\Datos\");

load("XoI.mat");
load("YoI.mat");
load("espacio3Ccas.mat");
load("espacio3CcasRGB.mat");
load("espacio3CcasLab.mat");

% RSL

XColor = XoI(YoI==1, espacio3Ccas);
XFondo = XoI(YoI==0, espacio3Ccas);

P = mean(XColor);

NP = XColor;
vector_distancia = calcula_distancia_Mahalanobis_punto_a_nube_puntos(XColor, XFondo, P, NP);
dMaxNPI = max(vector_distancia);

NP = XFondo;
vector_distancia_fondo = calcula_distancia_Mahalanobis_punto_a_nube_puntos(XColor, XFondo, P, NP);
dMinNPF = min(vector_distancia_fondo);

umbrales = (dMinNPF:0.1:dMaxNPI);
maxAciertos = 0;

for i = 1:length(umbrales)

    umbral = umbrales(i);

    aciertosColor = sum(vector_distancia <= umbral);
    aciertosFondo = sum(vector_distancia_fondo > umbral);

    aciertos = aciertosColor + aciertosFondo;

    if aciertos > maxAciertos
        maxAciertos = aciertos;
        mejorUmbral = umbral;
    end

end

umbralRSL = mejorUmbral;
centroideRSL = P;

save("Datos\umbralRSL", "umbralRSL");
save("Datos\centroideRSL", "centroideRSL");


% RGB

XColor = XoI(YoI==1, espacio3CcasRGB);
XFondo = XoI(YoI==0, espacio3CcasRGB);

P = mean(XColor);

NP = XColor;
[vector_distancia, mCovRGB] = calcula_distancia_Mahalanobis_punto_a_nube_puntos(XColor, XFondo, P, NP);
dMaxNPI = max(vector_distancia);

NP = XFondo;
[vector_distancia_fondo, mCovRGB] = calcula_distancia_Mahalanobis_punto_a_nube_puntos(XColor, XFondo, P, NP);
dMinNPF = min(vector_distancia_fondo);

umbrales = (dMinNPF:0.1:dMaxNPI);
maxAciertos = 0;

for i = 1:length(umbrales)

    umbral = umbrales(i);

    aciertosColor = sum(vector_distancia <= umbral);
    aciertosFondo = sum(vector_distancia_fondo > umbral);

    aciertos = aciertosColor + aciertosFondo;

    if aciertos > maxAciertos
        maxAciertos = aciertos;
        mejorUmbral = umbral;
    end

end

umbralRGB = mejorUmbral;
centroideRGB = P;

save("Datos\umbralRGB", "umbralRGB");
save("Datos\centroideRGB", "centroideRGB");
save("Datos\mCovRGB", "mCovRGB");


% Lab

XColor = XoI(YoI==1, espacio3CcasLab);
XFondo = XoI(YoI==0, espacio3CcasLab);

P = mean(XColor);

NP = XColor;
vector_distancia = calcula_distancia_Mahalanobis_punto_a_nube_puntos(XColor, XFondo, P, NP);
dMaxNPI = max(vector_distancia);

NP = XFondo;
vector_distancia_fondo = calcula_distancia_Mahalanobis_punto_a_nube_puntos(XColor, XFondo, P, NP);
dMinNPF = min(vector_distancia_fondo);

umbrales = (dMinNPF:0.1:dMaxNPI);
maxAciertos = 0;

for i = 1:length(umbrales)

    umbral = umbrales(i);

    aciertosColor = sum(vector_distancia <= umbral);
    aciertosFondo = sum(vector_distancia_fondo > umbral);

    aciertos = aciertosColor + aciertosFondo;

    if aciertos > maxAciertos
        maxAciertos = aciertos;
        mejorUmbral = umbral;
    end

end

umbralLab = mejorUmbral;
centroideLab = P;

save("Datos\umbralLab", "umbralLab");
save("Datos\centroideLab", "centroideLab");