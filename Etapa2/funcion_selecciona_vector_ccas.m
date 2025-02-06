function [espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas(XoI,YoI,dim)

    numDescriptores = size(XoI, 2); 
    J = [];
    ind = [];
    
    for i=1:numDescriptores
        valor = indiceJ(XoI(:,i),YoI);
        % if valor > 0.1
            ind = [ind; i];
        % end
    end
    
    if size(ind,1) == 0
        ind = 1:12;
    end
    
    comb = combnk(ind, dim);
   
    nComb = size(comb, 1);
    
    for i=1:nComb
        J = [J; indiceJ(XoI(:,comb(i,:)), YoI)];
    end
    
    [JMax, indMax] = max(J);
    
    espacioCcas = comb(indMax,:);
    JespacioCcas = JMax;

end