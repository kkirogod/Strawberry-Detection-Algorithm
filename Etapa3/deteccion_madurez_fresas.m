function imgBin_R = deteccion_madurez_fresas(img, img_seg, XoI_R, YoI_R, XoI_V, YoI_V)

    [N, M]=size(img(:,:,1));

    imgBin_R = deteccionFresasKNN(img, XoI_R, YoI_R);
    imgBin_R = round(imresize(imgBin_R,[N M],'nearest'));

    imgBin_V = deteccionFresasKNN(img, XoI_V, YoI_V);
    imgBin_V = round(imresize(imgBin_V,[N M],'nearest'));

    Io_R = funcion_visualiza(img,logical(imgBin_R),[255 0 0],false);
    Io = funcion_visualiza(Io_R,logical(imgBin_V),[255 255 0],false);

    figure, imshow(img); title("Imagen original")

    umbral = 200;

    [IEtiq, NumFresas] = bwlabel(img_seg);

    for i = 1:NumFresas

        fresa_i_rojo = (IEtiq == i) & imgBin_R;
        fresa_i_verde = (IEtiq == i) & imgBin_V;

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

