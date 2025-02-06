% Función que recibe como entradas un punto P (vector columna) y una nube de
% puntos NP (cada columna un punto). La función devuelve un vector fila con las
% distancias de Mahalanobis de cada punto de la nube de puntos al punto P.

function [vector_distancia, mCov] = calcula_distancia_Mahalanobis_punto_a_nube_puntos(XColor, XFondo, P, NP)
    
    mCov1 = cov(XColor);
    mCov2 = cov(XFondo);
    
    N1 = size(XColor, 1);
    N2 = size(XFondo, 1);
    numDatos = N1+N2;
    
    mCov = ((N1-1)*mCov1 + (N2-1)*mCov2)/(numDatos-2);

    numDatos = size(NP, 1);

    vector_distancia = [];
    
    for j=1:numDatos
        X = NP(j,:);
        vector_distancia(j,1)=sqrt((X-P)*pinv(mCov)*(X-P)');
    end

end