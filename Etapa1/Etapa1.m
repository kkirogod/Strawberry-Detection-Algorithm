%% ETAPA 1: OBTENCIÓN Y ANÁLISIS DE DATOS: PATRONES DE ENTRENAMIENTO

% PASO 1.1: Obtención de muestras de los colores representativos 
% de la imagen

clear, clc, close all

addpath("..\Material_Imagenes\01_MuestrasColores\")

img1 = imread("Color1.jpeg");
img2 = imread("Color2.jpeg");
img3 = imread("Color3.jpeg");

% 1.- Para cada una de las tres imágenes de color de entrada, obtener 
% las matrices R, G, B, H, S, I, Y, U, V, L, a, b

% RGB
R1 = img1(:,:,1); 
G1 = img1(:,:,2);
B1 = img1(:,:,3);

R2 = img2(:,:,1); 
G2 = img2(:,:,2);
B2 = img2(:,:,3);

R3 = img3(:,:,1); 
G3 = img3(:,:,2);
B3 = img3(:,:,3);

% HS
hsv1 = rgb2hsv(img1);
H1 = hsv1(:,:,1);
S1 = hsv1(:,:,2);

hsv2 = rgb2hsv(img2);
H2 = hsv2(:,:,1);
S2 = hsv2(:,:,2);

hsv3 = rgb2hsv(img3);
H3 = hsv3(:,:,1);
S3 = hsv3(:,:,2);

% I
I1 = (double(R1) + double(G1) + double(B1)) / 3;
I2 = (double(R2) + double(G2) + double(B2)) / 3;
I3 = (double(R3) + double(G3) + double(B3)) / 3;

% LAB
lab1 = rgb2lab(img1);
L1 = lab1(:,:,1);
a1 = lab1(:,:,2);
b1 = lab1(:,:,3);

lab2 = rgb2lab(img2);
L2 = lab2(:,:,1);
a2 = lab2(:,:,2);
b2 = lab2(:,:,3);

lab3 = rgb2lab(img3);
L3 = lab3(:,:,1);
a3 = lab3(:,:,2);
b3 = lab3(:,:,3);


% 2.- Obtener las matrices anteriores (R, G, B, H, S, I, Y, U, V, L, a, b) 
% normalizadas en el rango 0-1

R1_norm = double(R1) / 255;
G1_norm = double(G1) / 255;
B1_norm = double(B1) / 255;

R2_norm = double(R2) / 255;
G2_norm = double(G2) / 255;
B2_norm = double(B2) / 255;

R3_norm = double(R3) / 255;
G3_norm = double(G3) / 255;
B3_norm = double(B3) / 255;

H1_norm = H1;
S1_norm = S1;

H2_norm = H2;
S2_norm = S2;

H3_norm = H3;
S3_norm = S3;

I1_norm = I1 / 255;
I2_norm = I2 / 255;
I3_norm = I3 / 255;

% YUV

Y1 = 0.299*R1_norm + 0.587*G1_norm + 0.114*B1_norm;
U1 = 0.493*(B1_norm-Y1);
V1 = 0.877*(R1_norm-Y1);

Y2 = 0.299*R2_norm + 0.587*G2_norm + 0.114*B2_norm;
U2 = 0.493*(B2_norm-Y2);
V2 = 0.877*(R2_norm-Y2);

Y3 = 0.299*R3_norm + 0.587*G3_norm + 0.114*B3_norm;
U3 = 0.493*(B3_norm-Y3);
V3 = 0.877*(R3_norm-Y3);

%

Y1_norm = Y1;
U1_norm = mat2gray(U1,[-0.436 0.436]);
V1_norm = mat2gray(V1,[-0.615 0.615]);

Y2_norm = Y2;
U2_norm = mat2gray(U2,[-0.436 0.436]);
V2_norm = mat2gray(V2,[-0.615 0.615]);

Y3_norm = Y3;
U3_norm = mat2gray(U3,[-0.436 0.436]);
V3_norm = mat2gray(V3,[-0.615 0.615]);

L1_norm = double(L1) / 100;
a1_norm = mat2gray(a1,[-128 127]);
b1_norm = mat2gray(b1,[-128 127]);

L2_norm = double(L2) / 100;
a2_norm = mat2gray(a2,[-128 127]);
b2_norm = mat2gray(b2,[-128 127]);

L3_norm = double(L3) / 100;
a3_norm = mat2gray(a3,[-128 127]);
b3_norm = mat2gray(b3,[-128 127]);


% 3.- Generar la matriz ValoresColores, compuesta por los valores 
% normalizados R, G, B, H, S, I, Y, U, V, L, a, b, en los píxeles 
% etiquetados de todas las imágenes marcadas manualmente.

% Además, se debe generar el vector CodifValoresColores, que especificará 
% la codificación del color al que corresponden las filas de las matrices 
% de datos anteriores.

ValoresColores = [];
CodifValoresColores = [];

intensidades = [255, 128, 64, 32];

img1Seg = imread("Color1_MuestraColores.tif");
img2Seg = imread("Color2_MuestraColores.tif");
img3Seg = imread("Color3_MuestraColores.tif");

[valoresColores1, codifValoresColores1] = getValoresColores(img1Seg, R1_norm, G1_norm, B1_norm, H1_norm, S1_norm, I1_norm, Y1_norm, U1_norm, V1_norm, L1_norm, a1_norm, b1_norm, intensidades);
[valoresColores2, codifValoresColores2] = getValoresColores(img2Seg, R2_norm, G2_norm, B2_norm, H2_norm, S2_norm, I2_norm, Y2_norm, U2_norm, V2_norm, L2_norm, a2_norm, b2_norm, intensidades);
[valoresColores3, codifValoresColores3] = getValoresColores(img3Seg, R3_norm, G3_norm, B3_norm, H3_norm, S3_norm, I3_norm, Y3_norm, U3_norm, V3_norm, L3_norm, a3_norm, b3_norm, intensidades);

ValoresColores = [valoresColores1; valoresColores2; valoresColores3];
CodifValoresColores = [codifValoresColores1; codifValoresColores2; codifValoresColores3];

disp('ValoresColores:');
disp(ValoresColores);
disp('CodifValoresColores:');
disp(CodifValoresColores);


% PASO 1.2.: Representación de las muestras de color obtenidas en los 
% diferentes espacios de color considerados.

% 1.- Representa las siguientes gráficas:

% Colores para las etiquetas:
% Rojo Fresa (255), Verde Fresa (128), Verde Planta (64), Negro Lona (32)
colorRojo = [1 0 0]; % Rojo
colorVerde = [0 1 0]; % Verde
colorAzul = [0 0 1]; % Azul
colorNegro = [0 0 0]; % Negro

rojoFresa = CodifValoresColores == 255;
verdeFresa = CodifValoresColores == 128;
verdePlanta = CodifValoresColores == 64;
negroLona = CodifValoresColores == 32;

%% Gráfica RGB - Espacio RGB con plot3
figure;
hold on;
plot3(ValoresColores(rojoFresa, 1), ValoresColores(rojoFresa, 2), ValoresColores(rojoFresa, 3), '.', 'Color', colorRojo);
plot3(ValoresColores(verdeFresa, 1), ValoresColores(verdeFresa, 2), ValoresColores(verdeFresa, 3), '.', 'Color', colorVerde);
plot3(ValoresColores(verdePlanta, 1), ValoresColores(verdePlanta, 2), ValoresColores(verdePlanta, 3), '.', 'Color', colorAzul);
plot3(ValoresColores(negroLona, 1), ValoresColores(negroLona, 2), ValoresColores(negroLona, 3), '.', 'Color', colorNegro);
xlabel('R');
ylabel('G');
zlabel('B');
title('Gráfica RGB');
grid on;
hold off;

%% Gráfica HS - Espacio HS con plot
figure;
hold on;
plot(ValoresColores(rojoFresa, 4), ValoresColores(rojoFresa, 5), '.', 'Color', colorRojo);
plot(ValoresColores(verdeFresa, 4), ValoresColores(verdeFresa, 5), '.', 'Color', colorVerde);
plot(ValoresColores(verdePlanta, 4), ValoresColores(verdePlanta, 5), '.', 'Color', colorAzul);
plot(ValoresColores(negroLona, 4), ValoresColores(negroLona, 5), '.', 'Color', colorNegro);
xlabel('H');
ylabel('S');
title('Gráfica HS');
grid on;
hold off;

%% Gráfica UV - Espacio YUV con plot
figure;
hold on;
plot(ValoresColores(rojoFresa, 8), ValoresColores(rojoFresa, 9), '.', 'Color', colorRojo);
plot(ValoresColores(verdeFresa, 8), ValoresColores(verdeFresa, 9), '.', 'Color', colorVerde);
plot(ValoresColores(verdePlanta, 8), ValoresColores(verdePlanta, 9), '.', 'Color', colorAzul);
plot(ValoresColores(negroLona, 8), ValoresColores(negroLona, 9), '.', 'Color', colorNegro);
xlabel('U');
ylabel('V');
title('Gráfica UV');
grid on;
hold off;

%% Gráfica ab - Espacio Lab con plot
figure;
hold on;
plot(ValoresColores(rojoFresa, 11), ValoresColores(rojoFresa, 12), '.', 'Color', colorRojo);
plot(ValoresColores(verdeFresa, 11), ValoresColores(verdeFresa, 12), '.', 'Color', colorVerde);
plot(ValoresColores(verdePlanta, 11), ValoresColores(verdePlanta, 12), '.', 'Color', colorAzul);
plot(ValoresColores(negroLona, 11), ValoresColores(negroLona, 12), '.', 'Color', colorNegro);
xlabel('a');
ylabel('b');
title('Gráfica ab');
grid on;
hold off;


% 3.- Recalcula los valores de H en ValoresColores de acuerdo a la siguiente 
% ecuación:

% 𝐻𝑟𝑒𝑐𝑎𝑙𝑐𝑢𝑙𝑎𝑑𝑜 = {
%                   1 − 2 ∗ 𝐻 𝑠𝑖 𝐻 ≤ 0.5
%                   2 ∗ (𝐻 − 0.5) 𝑠𝑖 𝐻 > 0.5

% Vuelve a representar la gráfica HS anterior, utilizando los valores 
% actualizados de H y observa las diferencias.

H = ValoresColores(:, 4);

H_recalculado = zeros(size(H));

H_recalculado(H <= 0.5) = 1 - 2 * H(H <= 0.5);
H_recalculado(H > 0.5) = 2 * (H(H > 0.5) - 0.5);

ValoresColores(:, 4) = H_recalculado;

figure;
hold on;
plot(ValoresColores(rojoFresa, 4), ValoresColores(rojoFresa, 5), '.', 'Color', colorRojo);
plot(ValoresColores(verdeFresa, 4), ValoresColores(verdeFresa, 5), '.', 'Color', colorVerde);
plot(ValoresColores(verdePlanta, 4), ValoresColores(verdePlanta, 5), '.', 'Color', colorAzul);
plot(ValoresColores(negroLona, 4), ValoresColores(negroLona, 5), '.', 'Color', colorNegro);
xlabel('H recalculado');
ylabel('S');
title('Gráfica HS con H recalculado');
grid on;
hold off;


save("Datos\ValoresColores.mat", "ValoresColores");
save("Datos\CodifValoresColores.mat", "CodifValoresColores");