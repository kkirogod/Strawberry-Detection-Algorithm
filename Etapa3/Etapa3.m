%% ETAPA 2: DETECCIÓN DE FRESAS Y MEDIDA DEL GRADO DE MADUREZ

clear, clc, close all

addpath("..\Etapa2\Datos\")
addpath("..\Etapa2\")
addpath("..\Material_Imagenes\03_MuestrasFresas\")

load("Datos\espacio3CcasRGB.mat")
load("XoI.mat");
load("YoI.mat");

img1_seg = imread("SegFresas1_Gold.tif");
img1 = imread("SegFresas1.tif");
img2_seg = imread("SegFresas2_Gold.tif");
img2 = imread("SegFresas2.tif");
img3_seg = imread("SegFresas3_Gold.tif");
img3 = imread("SegFresas3.tif");

% figure, imshow(img1)
% figure, imshow(img2)
% figure, imshow(img3)
% figure, imshow(img1_seg)
% figure, imshow(img2_seg)
% figure, imshow(img3_seg)

XoI_RGB_Rojo = XoI(:, espacio3CcasRGB)*255;
[N1, M1]=size(img1(:,:,1));
[N2, M2]=size(img2(:,:,1));
[N3, M3]=size(img3(:,:,1));

YoI_Rojo = YoI;

%% 1.- Detectar los píxeles rojo fresa

imgBin1_KNN_Rojo = deteccionFresasKNN(img1, XoI_RGB_Rojo, YoI_Rojo);
imgBin1_KNN_Rojo = round(imresize(imgBin1_KNN_Rojo,[N1 M1],'nearest'));
funcion_visualiza(img1,logical(imgBin1_KNN_Rojo),[0 0 255],true); title("Rojo Fresa")
% figure, imshow(imgBin1_KNN_Rojo)

imgBin2_KNN_Rojo = deteccionFresasKNN(img2, XoI_RGB_Rojo, YoI_Rojo);
imgBin2_KNN_Rojo = round(imresize(imgBin2_KNN_Rojo,[N2 M2],'nearest'));
funcion_visualiza(img2,logical(imgBin2_KNN_Rojo),[0 0 255],true); title("Rojo Fresa")
% figure, imshow(imgBin2_KNN_Rojo)

imgBin3_KNN_Rojo = deteccionFresasKNN(img3, XoI_RGB_Rojo, YoI_Rojo);
imgBin3_KNN_Rojo = round(imresize(imgBin3_KNN_Rojo,[N3 M3],'nearest'));
funcion_visualiza(img3,logical(imgBin3_KNN_Rojo),[0 0 255],true); title("Rojo Fresa")
% figure, imshow(imgBin3_KNN_Rojo)


%% 2.- Detectar los píxeles verde fresa

addpath("..\Etapa1\Datos\");
addpath("..\FuncionesMatlabMaterialAyuda\");

load("CodifValoresColores.mat");
load("ValoresColores.mat");

X = ValoresColores;
Y = CodifValoresColores;

codifClases = unique(Y);

XoI = []; YoI = [];


% Clase 1 (Verde Fresa)

XoIClase = []; YoIClase = [];
clasesOI = 3;
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
clasesOI = [1 2 4];
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


XoI_RGB_Verde = XoI(:, espacio3CcasRGB)*255;
YoI_Verde = YoI;


imgBin1_KNN_Verde = deteccionFresasKNN(img1, XoI_RGB_Verde, YoI_Verde);
imgBin1_KNN_Verde = round(imresize(imgBin1_KNN_Verde,[N1 M1],'nearest'));
funcion_visualiza(img1,logical(imgBin1_KNN_Verde),[0 0 255],true); title("Verde Fresa")
% figure, imshow(imgBin1_KNN_Verde)

imgBin2_KNN_Verde = deteccionFresasKNN(img2, XoI_RGB_Verde, YoI_Verde);
imgBin2_KNN_Verde = round(imresize(imgBin2_KNN_Verde,[N2 M2],'nearest'));
funcion_visualiza(img2,logical(imgBin2_KNN_Verde),[0 0 255],true); title("Verde Fresa")
% figure, imshow(imgBin2_KNN_Verde)

imgBin3_KNN_Verde = deteccionFresasKNN(img3, XoI_RGB_Verde, YoI_Verde);
imgBin3_KNN_Verde = round(imresize(imgBin3_KNN_Verde,[N3 M3],'nearest'));
funcion_visualiza(img3,logical(imgBin3_KNN_Verde),[0 0 255],true); title("Verde Fresa")
% figure, imshow(imgBin3_KNN_Verde)


%% 3.- Visualizar sobre la imagen original los resultados obtenidos 
% (en rojo, la detección del rojo fresa; en amarillo, la detección del 
% verde fresa)

Io_Rojo1 = funcion_visualiza(img1,logical(imgBin1_KNN_Rojo),[255 0 0],false);
Io_RojoVerde1 = funcion_visualiza(Io_Rojo1,logical(imgBin1_KNN_Verde),[255 255 0],false);
figure, imshow(Io_RojoVerde1); title("Imagen 1")

Io_Rojo2 = funcion_visualiza(img2,logical(imgBin2_KNN_Rojo),[255 0 0],false);
Io_RojoVerde2 = funcion_visualiza(Io_Rojo2,logical(imgBin2_KNN_Verde),[255 255 0],false);
figure, imshow(Io_RojoVerde2); title("Imagen 2")

Io_Rojo3 = funcion_visualiza(img3,logical(imgBin3_KNN_Rojo),[255 0 0],false);
Io_RojoVerde3 = funcion_visualiza(Io_Rojo3,logical(imgBin3_KNN_Verde),[255 255 0],false);
figure, imshow(Io_RojoVerde3); title("Imagen 3")


%% 4.- Detección de fresas rojas presentes y medida del grado de madurez 
%  5.- Visualizar cada fresa roja detectada en una ventana tipo figure, en 
% rojo los píxeles rojos y en amarillo los píxeles verdes. El título de la 
% imagen mostrada debe indicar el grado de madurez de la fresa. 

imgBin1_Rojo_2Pasos = deteccion_madurez_fresas(img1, img1_seg, XoI_RGB_Rojo, YoI_Rojo, XoI_RGB_Verde, YoI_Verde);
imgBin2_Rojo_2Pasos = deteccion_madurez_fresas(img2, img2_seg, XoI_RGB_Rojo, YoI_Rojo, XoI_RGB_Verde, YoI_Verde);
imgBin3_Rojo_2Pasos = deteccion_madurez_fresas(img3, img3_seg, XoI_RGB_Rojo, YoI_Rojo, XoI_RGB_Verde, YoI_Verde);


%% 6.- Implementar una segunda versión de este algoritmo, donde la 
% detección de píxeles rojofresa y verde-fresa se realice en un solo paso, 
% utilizando RGB como descripción matemática y un clasificador kNN (ó SVM).

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


% Clase 2 (Verde Fresa)

XoIClase = []; YoIClase = [];
clasesOI = 3;
codifClasesOI = codifClases(clasesOI);
nClasesOI = length(clasesOI);

for i=1:nClasesOI

    filasOI = Y == codifClasesOI(i); 
    XoI_i = X(filasOI,:);

    XoIClase = [XoIClase; XoI_i];
    YoIClase = [YoIClase; 2*ones(size(XoI_i, 1), 1)];

end

XoIClase2 = XoIClase;
YoIClase2 = YoIClase;


% Clase 3 (Resto)

XoIClase = []; YoIClase = [];
clasesOI = [1 2];
codifClasesOI = codifClases(clasesOI);
nClasesOI = length(clasesOI);

for i=1:nClasesOI

    filasOI = Y == codifClasesOI(i); 
    XoI_i = X(filasOI,:);

    XoIClase = [XoIClase; XoI_i];
    YoIClase = [YoIClase; zeros(size(XoI_i, 1), 1)];

end

XoIClase3 = XoIClase;
YoIClase3 = YoIClase;


% Union de las clases
XoI = [XoIClase1; XoIClase2; XoIClase3];
YoI = [YoIClase1; YoIClase2; YoIClase3];


XoI_RGB_3Clases= XoI(:, espacio3CcasRGB)*255;
YoI_3Clases = YoI;

imgBin1_Rojo_1Paso = deteccion_madurez_fresas_1paso(img1, img1_seg, XoI_RGB_3Clases, YoI_3Clases);
imgBin2_Rojo_1Paso = deteccion_madurez_fresas_1paso(img2, img2_seg, XoI_RGB_3Clases, YoI_3Clases);
imgBin3_Rojo_1Paso = deteccion_madurez_fresas_1paso(img3, img3_seg, XoI_RGB_3Clases, YoI_3Clases);


%% 7.- Comparar el rendimiento (sensibilidad, especificidad y acierto) de 
% ambas versiones del algoritmo

% IMAGEN 1

[Sens1_2Pasos, Esp1_2Pasos, Prec1_2Pasos, FalPos1_2Pasos] = funcion_metricas(imgBin1_Rojo_2Pasos, img1_seg);
[Sens1_1Paso, Esp1_1Paso, Prec1_1Paso, FalPos1_1Paso] = funcion_metricas(imgBin1_Rojo_1Paso, img1_seg);

% Crear una tabla con los resultados
detecciones = {'2 Pasos'; '1 Paso';};
Sensibilidad = [Sens1_2Pasos; Sens1_1Paso;];
Especificidad = [Esp1_2Pasos; Esp1_1Paso;];
Precision = [Prec1_2Pasos; Prec1_1Paso;];

T = table(detecciones, Sensibilidad, Especificidad, Precision);

% Mostrar la tabla
disp(T);


% IMAGEN 2

[Sens2_2Pasos, Esp2_2Pasos, Prec2_2Pasos, FalPos2_2Pasos] = funcion_metricas(imgBin2_Rojo_2Pasos, img2_seg);
[Sens2_1Paso, Esp2_1Paso, Prec2_1Paso, FalPos2_1Paso] = funcion_metricas(imgBin2_Rojo_1Paso, img2_seg);

% Crear una tabla con los resultados
detecciones = {'2 Pasos'; '1 Paso';};
Sensibilidad = [Sens2_2Pasos; Sens2_1Paso;];
Especificidad = [Esp2_2Pasos; Esp2_1Paso;];
Precision = [Prec2_2Pasos; Prec2_1Paso;];

T = table(detecciones, Sensibilidad, Especificidad, Precision);

% Mostrar la tabla
disp(T);


% IMAGEN 3

[Sens3_2Pasos, Esp3_2Pasos, Prec3_2Pasos, FalPos3_2Pasos] = funcion_metricas(imgBin3_Rojo_2Pasos, img3_seg);
[Sens3_1Paso, Esp3_1Paso, Prec3_1Paso, FalPos3_1Paso] = funcion_metricas(imgBin3_Rojo_1Paso, img3_seg);

% Crear una tabla con los resultados
detecciones = {'2 Pasos'; '1 Paso';};
Sensibilidad = [Sens3_2Pasos; Sens3_1Paso;];
Especificidad = [Esp3_2Pasos; Esp3_1Paso;];
Precision = [Prec3_2Pasos; Prec3_1Paso;];

T = table(detecciones, Sensibilidad, Especificidad, Precision);

% Mostrar la tabla
disp(T);


% ANALISIS DE RESULTADOS

Sens_prom_2Pasos = mean([Sens1_2Pasos, Sens2_2Pasos, Sens3_2Pasos]);
Esp_prom_2Pasos = mean([Esp1_2Pasos, Esp2_2Pasos, Esp3_2Pasos]);
Prec_prom_2Pasos = mean([Prec1_2Pasos, Prec2_2Pasos, Prec3_2Pasos]);

Sens_prom_1Paso = mean([Sens1_1Paso, Sens2_1Paso, Sens3_1Paso]);
Esp_prom_1Paso = mean([Esp1_1Paso, Esp2_1Paso, Esp3_1Paso]);
Prec_prom_1Paso = mean([Prec1_1Paso, Prec2_1Paso, Prec3_1Paso]);

Sensibilidad_prom = [Sens_prom_2Pasos; Sens_prom_1Paso;];
Especificidad_prom = [Esp_prom_2Pasos; Esp_prom_1Paso;];
Precision_prom = [Prec_prom_2Pasos; Prec_prom_1Paso;];

T_prom = table(detecciones, Sensibilidad_prom, Especificidad_prom, Precision_prom);

disp(T_prom);

[~, idx_best] = max(Sensibilidad_prom);
mejor_deteccion = detecciones{idx_best};
disp(['El tipo de deteccion mas SENSIBLE es: ', mejor_deteccion]);

[~, idx_best] = max(Especificidad_prom);
mejor_deteccion = detecciones{idx_best};
disp(['El tipo de deteccion mas ESPECIFICO es: ', mejor_deteccion]);

[~, idx_best] = max(Precision_prom);
mejor_deteccion = detecciones{idx_best};
disp(['El tipo de deteccion mas PRECISO es: ', mejor_deteccion]);
