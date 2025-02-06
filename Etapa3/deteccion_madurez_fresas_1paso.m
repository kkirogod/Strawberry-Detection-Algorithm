function imgBin_R = deteccion_madurez_fresas_1paso(img, img_seg, XoI, YoI)

    [N, M]=size(img(:,:,1));

    imgBin = deteccionFresasKNN(img, XoI, YoI);
    imgBin = round(imresize(imgBin,[N M],'nearest'));

    imgBin_R = imgBin == 1;

    Io_R = funcion_visualiza(img,logical(imgBin==1),[255 0 0],false);
    Io = funcion_visualiza(Io_R,logical(imgBin==2),[255 255 0],false);

    figure, imshow(img); title("Imagen original")

    umbral = 200;

    [IEtiq, NumFresas] = bwlabel(img_seg);

    for i = 1:NumFresas

        fresa_i_rojo = (IEtiq == i) & (imgBin == 1);
        fresa_i_verde = (IEtiq == i) & (imgBin == 2);

        numPix_rojos = sum(fresa_i_rojo(:));
        numPix_verdes = sum(fresa_i_verde(:));

        numPix = numPix_rojos + numPix_verdes;

        if numPix_rojos >= umbral

            madurez = numPix_rojos / numPix;

            % coordenadas mínimas y máximas de la fresa i
            [row, col] = find(IEtiq == i);
            minRow = max(min(row) - 20, 1);  % Margen de 20 píxeles
            maxRow = min(max(row) + 20, size(Io, 1));
            minCol = max(min(col) - 20, 1);
            maxCol = min(max(col) + 20, size(Io, 2));

            imgZoomFresa = Io(minRow:maxRow, minCol:maxCol, :);

            figure, imshow(imgZoomFresa);

            title(['Fresa ', num2str(i), ' - Grado de madurez: ', num2str(madurez)]);
        end
        
    end

end

