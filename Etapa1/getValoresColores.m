function [valoresColores, codifValoresColores] = getValoresColores(imgSeg, R_norm, G_norm, B_norm, H_norm, S_norm, I_norm, Y_norm, U_norm, V_norm, L_norm, a_norm, b_norm, intensidades)

    codifValoresColores = [];
    valoresColores = [];

    for intensidad = intensidades

        pixOI = imgSeg == intensidad;

        R_OI = R_norm(pixOI);
        G_OI = G_norm(pixOI);
        B_OI = B_norm(pixOI);
        H_OI = H_norm(pixOI);
        S_OI = S_norm(pixOI);
        I_OI = I_norm(pixOI);
        Y_OI = Y_norm(pixOI);
        U_OI = U_norm(pixOI);
        V_OI = V_norm(pixOI);
        L_OI = L_norm(pixOI);
        a_OI = a_norm(pixOI);
        b_OI = b_norm(pixOI);

        if ~isempty(R_OI)
            nuevosValores = [R_OI, G_OI, B_OI, H_OI, S_OI, I_OI, Y_OI, U_OI, V_OI, L_OI, a_OI, b_OI];
            valoresColores = [valoresColores; nuevosValores];
            codifValoresColores = [codifValoresColores; repmat(intensidad, length(R_OI), 1)];
        end
        
    end
end
