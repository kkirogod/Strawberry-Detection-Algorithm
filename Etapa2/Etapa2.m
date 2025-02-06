%% ETAPA 2: DETECCIÓN DE FRESAS EN DOS PASOS

clear, clc, close all

addpath("..\Etapa1\Datos\");
addpath("..\FuncionesMatlabMaterialAyuda\");

load("CodifValoresColores.mat");
load("ValoresColores.mat");


%% PASO 2.1: SEGMENTACIÓN DEL COLOR ROJO FRESA


% 2.1.1 Selección de conjuntos de descriptores

X = ValoresColores;
Y = CodifValoresColores;

codifClases = unique(Y);

XoI = []; YoI = [];


% Clase 1 (Rojo Fresa)

XoIClase = []; YoIClase = [];
clasesOI = 4;
codifClasesOI = codifClases(clasesOI);
nClasesOI = length(clasesOI);

for i=1:nClasesOI

    filasOI = Y ==codifClasesOI(i); 
    XoI_i = X(filasOI,:);

    XoIClase = [XoIClase; XoI_i];
    YoIClase = [YoIClase; ones(size(XoI_i, 1), 1)];
    
end

XoIClase1 = XoIClase;
YoIClase1 = YoIClase;


% Clase 2 (Resto de colores)

XoIClase = []; YoIClase = [];
clasesOI = [1 2 3];
codifClasesOI = codifClases(clasesOI);
nClasesOI = length(clasesOI);

for i=1:nClasesOI

    filasOI = Y == codifClasesOI(i); 
    XoI_i = X(filasOI,:);

    XoIClase = [XoIClase; XoI_i];
    YoIClase = [YoIClase; zeros(size(XoI_i, 1), 1)];

end

XoIClase2 = XoIClase;
YoIClase2 = YoIClase;


% Union de las clases

XoI = [XoIClase1; XoIClase2];
YoI = [YoIClase1; YoIClase2];


% 2.1.1.1.- Considerando nuestro problema de clasificación, cuantificar la 
% separabilidad que proporcionan los espacios de color RGB, HSI, YUV y Lab 
% mediante CSM - ("Class Scatter Matrix", estimación de las matrices de 
% dispersión entre y dentro de las clases – se facilita función para 
% cálculo).

SeparRGB = indiceJ(XoI(:, [1 2 3]), YoI);
SeparHSI = indiceJ(XoI(:, [4 5 6]), YoI);
SeparYUV = indiceJ(XoI(:, [7 8 9]), YoI);
SeparLab = indiceJ(XoI(:, [10 11 12]), YoI);


% 2.1.1.2.- Seleccionar los conjuntos de 3, 4, 5 y 6 descriptores que 
% proporcionan mayor separabilidad.

dim = 3;
[espacio3Ccas, Jespacio3Ccas] = funcion_selecciona_vector_ccas(XoI, YoI, dim);
save("Datos\espacio3CCas.mat", "espacio3Ccas");

dim = 4;
[espacio4Ccas, Jespacio4Ccas] = funcion_selecciona_vector_ccas(XoI, YoI, dim);

dim = 5;
[espacio5Ccas, Jespacio5Ccas] = funcion_selecciona_vector_ccas(XoI, YoI, dim);

dim = 6;
[espacio6Ccas, Jespacio6Ccas] = funcion_selecciona_vector_ccas(XoI, YoI, dim);


% 2.1.1.3.- Este paso terminará con la siguiente selección de vectores 
% característica que se utilizarán en la siguiente etapa de clasificación:
% - R G B
% - L a b
% - Mejor combinación de 3 descriptores.
% - La combinación que se considere más adecuada de más descriptores 
% (4, 5 o 6) atendiendo a los datos de separabilidad.


espacio3CcasRGB = [1 2 3];
save("Datos\espacio3CcasRGB.mat", "espacio3CcasRGB");

espacio3CcasLab = [10 11 12];
save("Datos\espacio3CcasLab.mat", "espacio3CcasLab");


% La combinación que se considere más adecuada de más descriptores 
% (4, 5 o 6) atendiendo a los datos de separabilidad (mayor indice J):

J456 = [Jespacio4Ccas, Jespacio5Ccas, Jespacio6Ccas];
[JMax, ind] = max(J456);

if JMax == Jespacio4Ccas

    save("Datos\espacio4Ccas.mat", "espacio4Ccas");

elseif JMax == Jespacio5Ccas

    save("Datos\espacio5Ccas.mat", "espacio5Ccas");

elseif JMax == Jespacio6Ccas

    save("Datos\espacio6Ccas.mat", "espacio6Ccas");

end


% 2.1.2 Aplicación de diferentes estrategias de clasificación

% 2.1.2.1 Eliminación de valores anómalos en la clase de interés (ser 
% píxel de color rojo fresa): eliminar del conjunto de datos todas las 
% muestras de píxeles rojo fresa cuya componente roja sea inferior a 0.95.

filasOI = XoIClase1(:,1) >= 0.95;
XoIClase1 = XoIClase1(filasOI, :);
YoIClase1 = YoIClase1(filasOI);

XoI = [XoIClase1; XoIClase2];
YoI = [YoIClase1; YoIClase2];

save("Datos\XoI.mat", "XoI");
save("Datos\YoI.mat", "YoI");


% 2.1.2.3 Aplicación de clasificadores sobre las imágenes

clear, clc, close all

addpath("..\Material_Imagenes\02_MuestrasRojo\")
addpath("..\FuncionesMatlabMaterialAyuda\");
addpath("Mahalanobis\Datos\")
addpath("NN\Datos\")
addpath("Datos\")

load("Mahalanobis\Datos\centroideRGB.mat")
load("Mahalanobis\Datos\umbralRGB.mat")
load("Mahalanobis\Datos\mCovRGB.mat")
load("NN\Datos\net3ccasRGB.mat")
load("Datos\espacio3CcasRGB.mat")
load("XoI.mat");
load("YoI.mat");

img1_seg = imread("EvRojo1_Gold.tif");
img1 = imread("EvRojo1.tif");
img2_seg = imread("EvRojo2_Gold.tif");
img2 = imread("EvRojo2.tif");

% figure, imshow(img1)
% figure, imshow(img2)
% figure, imshow(img1_seg)
% figure, imshow(img2_seg)

XoI_RGB = XoI(:, espacio3CcasRGB)*255;
[N1, M1]=size(img1(:,:,1));
[N2, M2]=size(img2(:,:,1));

% KNN

imgBin1_KNN = deteccionFresasKNN(img1, XoI_RGB, YoI);
imgBin1_KNN = round(imresize(imgBin1_KNN,[N1 M1],'nearest'));
funcion_visualiza(img1,logical(imgBin1_KNN),[0 0 255],true); title("KNN")
% figure, imshow(imgBin1_KNN)

imgBin2_KNN = deteccionFresasKNN(img2, XoI_RGB, YoI);
imgBin2_KNN = round(imresize(imgBin2_KNN,[N2 M2],'nearest'));
funcion_visualiza(img2,logical(imgBin2_KNN),[0 0 255],true); title("KNN")
% figure, imshow(imgBin2_KNN)


% SVM (cuidado que tarda más que el resto)

imgBin1_SVM = deteccionFresasSVM(img1, XoI_RGB, YoI);
imgBin1_SVM = round(imresize(imgBin1_SVM,[N1 M1],'nearest'));
funcion_visualiza(img1,logical(imgBin1_SVM),[0 0 255],true); title("SVM")
% figure, imshow(imgBin1_SVM)

imgBin2_SVM = deteccionFresasSVM(img2, XoI_RGB, YoI);
imgBin2_SVM = round(imresize(imgBin2_SVM,[N2 M2],'nearest'));
funcion_visualiza(img2,logical(imgBin2_SVM),[0 0 255],true); title("SVM")
% figure, imshow(imgBin2_SVM)


% NN

% redondemaos a 0 y 1 para evitar los valores cercanos a 0

imgBin1_NN = round(deteccionFresasNN(img1, net));
imgBin1_NN = round(imresize(imgBin1_NN,[N1 M1],'nearest'));
funcion_visualiza(img1,logical(imgBin1_NN),[0 0 255],true); title("NN")
% figure, imshow(imgBin1_NN)

imgBin2_NN = round(deteccionFresasNN(img2, net));
imgBin2_NN = round(imresize(imgBin2_NN,[N2 M2],'nearest'));
funcion_visualiza(img2,logical(imgBin2_NN),[0 0 255],true); title("NN")
% figure, imshow(imgBin2_NN)


% Mahalanobis

imgBin1_Mahalanobis = round(deteccionFresasMahalanobis(img1, umbralRGB, centroideRGB, mCovRGB));
imgBin1_Mahalanobis = round(imresize(imgBin1_Mahalanobis,[N1 M1],'nearest'));
funcion_visualiza(img1,logical(imgBin1_Mahalanobis),[0 0 255],true); title("Mahalanobis")
% figure, imshow(imgBin1_Mahalanobis)

imgBin2_Mahalanobis = round(deteccionFresasMahalanobis(img2, umbralRGB, centroideRGB, mCovRGB));
imgBin2_Mahalanobis = round(imresize(imgBin2_Mahalanobis,[N2 M2],'nearest'));
funcion_visualiza(img2,logical(imgBin2_Mahalanobis),[0 0 255],true); title("Mahalanobis")
% figure, imshow(imgBin2_Mahalanobis)

    
% 2.1.2.4 Medida del rendimiento de cada modelo

% IMAGEN 1

[Sens_KNN_1, Esp_KNN_1, Prec_KNN_1, FalPos_KNN_1] = funcion_metricas(imgBin1_KNN, img1_seg);
[Sens_SVM_1, Esp_SVM_1, Prec_SVM_1, FalPos_SVM_1] = funcion_metricas(imgBin1_SVM, img1_seg);
[Sens_NN_1, Esp_NN_1, Prec_NN_1, FalPos_NN_1] = funcion_metricas(imgBin1_NN, img1_seg);
[Sens_Mahalanobis_1, Esp_Mahalanobis_1, Prec_Mahalanobis_1, FalPos_Mahalanobis_1] = funcion_metricas(imgBin1_Mahalanobis, img1_seg);

% Crear una tabla con los resultados
clasificadores = {'KNN'; 'SVM'; 'NN'; 'Mahalanobis'};
Sensibilidad = [Sens_KNN_1; Sens_SVM_1; Sens_NN_1; Sens_Mahalanobis_1];
Especificidad = [Esp_KNN_1; Esp_SVM_1; Esp_NN_1; Esp_Mahalanobis_1];
Accuracy = [Prec_KNN_1; Prec_SVM_1; Prec_NN_1; Prec_Mahalanobis_1];
FalsosPositivos = [FalPos_KNN_1; FalPos_SVM_1; FalPos_NN_1; FalPos_Mahalanobis_1];

T = table(clasificadores, Sensibilidad, Especificidad, Accuracy, FalsosPositivos);

% Mostrar la tabla
disp(T);


% IMAGEN 2

[Sens_KNN_2, Esp_KNN_2, Prec_KNN_2, FalPos_KNN_2] = funcion_metricas(imgBin2_KNN, img2_seg);
[Sens_SVM_2, Esp_SVM_2, Prec_SVM_2, FalPos_SVM_2] = funcion_metricas(imgBin2_SVM, img2_seg);
[Sens_NN_2, Esp_NN_2, Prec_NN_2, FalPos_NN_2] = funcion_metricas(imgBin2_NN, img2_seg);
[Sens_Mahalanobis_2, Esp_Mahalanobis_2, Prec_Mahalanobis_2, FalPos_Mahalanobis_2] = funcion_metricas(imgBin2_Mahalanobis, img2_seg);

% Crear una tabla con los resultados
clasificadores = {'KNN'; 'SVM'; 'NN'; 'Mahalanobis'};
Sensibilidad = [Sens_KNN_2; Sens_SVM_2; Sens_NN_2; Sens_Mahalanobis_2];
Especificidad = [Esp_KNN_2; Esp_SVM_2; Esp_NN_2; Esp_Mahalanobis_2];
Accuracy = [Prec_KNN_2; Prec_SVM_2; Prec_NN_2; Prec_Mahalanobis_2];
FalsosPositivos = [FalPos_KNN_2; FalPos_SVM_2; FalPos_NN_2; FalPos_Mahalanobis_2];

T2 = table(clasificadores, Sensibilidad, Especificidad, Accuracy, FalsosPositivos);

% Mostrar la tabla
disp(T2);


% ANALISIS DE RESULTADOS

Sens_KNN_prom = mean([Sens_KNN_1, Sens_KNN_2]);
Esp_KNN_prom = mean([Esp_KNN_1, Esp_KNN_2]);
Prec_KNN_prom = mean([Prec_KNN_1, Prec_KNN_2]);

Sens_SVM_prom = mean([Sens_SVM_1, Sens_SVM_2]);
Esp_SVM_prom = mean([Esp_SVM_1, Esp_SVM_2]);
Prec_SVM_prom = mean([Prec_SVM_1, Prec_SVM_2]);

Sens_NN_prom = mean([Sens_NN_1, Sens_NN_2]);
Esp_NN_prom = mean([Esp_NN_1, Esp_NN_2]);
Prec_NN_prom = mean([Prec_NN_1, Prec_NN_2]);

Sens_Mahalanobis_prom = mean([Sens_Mahalanobis_1, Sens_Mahalanobis_2]);
Esp_Mahalanobis_prom = mean([Esp_Mahalanobis_1, Esp_Mahalanobis_2]);
Prec_Mahalanobis_prom = mean([Prec_Mahalanobis_1, Prec_Mahalanobis_2]);

clasificadores = {'KNN'; 'SVM'; 'NN'; 'Mahalanobis'};

Sensibilidad_prom = [Sens_KNN_prom; Sens_SVM_prom; Sens_NN_prom; Sens_Mahalanobis_prom];
Especificidad_prom = [Esp_KNN_prom; Esp_SVM_prom; Esp_NN_prom; Esp_Mahalanobis_prom];
Precision_prom = [Prec_KNN_prom; Prec_SVM_prom; Prec_NN_prom; Prec_Mahalanobis_prom];

T_prom = table(clasificadores, Sensibilidad_prom, Especificidad_prom, Precision_prom);

disp(T_prom);

[~, idx_best] = max(Sensibilidad_prom);
mejor_clasificador = clasificadores{idx_best};
disp(['El clasificador mas SENSIBLE es: ', mejor_clasificador]);

[~, idx_best] = max(Especificidad_prom);
mejor_clasificador = clasificadores{idx_best};
disp(['El clasificador mas ESPECIFICO es: ', mejor_clasificador]);

[~, idx_best] = max(Precision_prom);
mejor_clasificador = clasificadores{idx_best};
disp(['El clasificador mas PRECISO es: ', mejor_clasificador]);