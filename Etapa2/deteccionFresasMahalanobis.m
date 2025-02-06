function deteccion = deteccionFresasMahalanobis(img, umbral, centroide, mCov)

    imresize(img, 0.5);
    
    % R = canal rojo de la imagen sobre la que se va a aplicar el clasificador 
    % (sólo para saber dimensiones de la imagen)
    R = img(:,:,1);
    [N, M]=size(R);
    
    % inicializamos la matriz resultado a 0
    deteccion = zeros(N,M);
    
    % PARA HACER EFICIENTE EL CLASIFICADOR SOLO LO LLAMAMOS UNA VEZ CON 
    % TODOS LOS DATOS

    % Recorremos por columna la matriz, y vamos poniendo la información de 
    % cada punto ( R G B ) en filas

    valoresRGBImagen = [];

    G = img(:,:,2); 
    B = img(:,:,3);
    
    for j=1:M
        valoresRGBImagen_temp = [R(:,j) G(:,j) B(:,j)];
        valoresRGBImagen = [valoresRGBImagen; valoresRGBImagen_temp];
    end

    NP = double(valoresRGBImagen) / 255;
    numDatos = size(NP, 1);
    vector_distancia = [];
    
    for j=1:numDatos
        X = NP(j,:);
        vector_distancia(j,1)=sqrt((X-centroide)*pinv(mCov)*(X-centroide)');
    end

    deteccionVector = vector_distancia <= umbral;

    % ESCRIBIMOS LA INFORMACION DE FORMA MATRICIAL TENIENDO EN CUENTA EL
    % ORDEN EN QUE SE GENERARON LOS DATOS DEL VECTOR, ES DECIR, VAMOS 
    % GUARDANDO POR COLUMNA. Del vector salida del KNN se extraen bloques 
    % del tamaño del número de filas y los vamos asignando a cada columna

    ind = 1;

    for j=1:M
        deteccion(:,j) = deteccionVector (ind:ind+N-1);
        ind = ind+N;
    end

end

