# Strawberry Detection Algorithm
Development of an algorithm for detecting strawberries in images by implementing color-based image segmentation techniques.

The algorithm will receive images as input and will return as output the segmentation of the detected red strawberries, offering information about their degree of ripeness.

![image](https://github.com/user-attachments/assets/3dbf0bae-3100-47ee-977e-40131d97be06)

## Descripción
Este proyecto implementa un algoritmo para la detección de fresas en imágenes mediante técnicas de segmentación basadas en color. Utiliza distintos espacios de color y métodos de clasificación para identificar y segmentar los píxeles correspondientes a fresas maduras y en desarrollo, permitiendo evaluar su grado de madurez.

## Objetivo
El objetivo principal es diseñar un sistema de segmentación que reciba imágenes de entrada y devuelva la segmentación de las fresas detectadas, proporcionando información sobre su estado de madurez.

## Etapas del Proyecto
### 1. Obtención y Análisis de Datos
- Obtención de muestras de los colores representativos de la imagen: rojo fresa, verde fresa, verde planta y negro lona.
- Representación en distintos espacios de color: RGB, HSI, YUV y CIE Lab.
- Normalización de los valores obtenidos.

### 2. Detección de Fresas
#### Segmentación del Color Rojo Fresa
- Selección de descriptores de color más relevantes.
- Aplicación de técnicas de clasificación:
  - Distancia de Mahalanobis
  - k-Vecinos Más Próximos (kNN)
  - Redes Neuronales
  - Máquinas de Vectores Soporte (SVM)
- Comparación de resultados y selección del mejor método.

#### Segmentación del Color Verde Fresa
- Uso de descriptores RGB y clasificación con kNN.

### 3. Detección de Fresas y Medición del Grado de Madurez
- Combinación de detecciones de rojo y verde fresa para identificar fresas completas.
- Cálculo del grado de madurez mediante la proporción de píxeles rojos y verdes.
- Comparación entre algoritmos de detección en dos pasos y en un solo paso.

## Requisitos
- MATLAB
- Paquetes de procesamiento de imágenes
- Conjunto de datos de imágenes de fresas

## Instalación y Uso
1. Clonar este repositorio:
   ```bash
   git clone https://github.com/kkirogod/Strawberry-Detection-Algorithm.git
   ```
2. Abrir MATLAB y ejecutar los scripts estapa por etapa.
3. Analizar los resultados y ajustar los parámetros según sea necesario.
