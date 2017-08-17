function [Nmax] = NmaxConv(base,data,SHAPE_ANALOG,SHAPE_TRAIN,SHAPE_VALID,sind,mod)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% M�TODO PARA ESCOLHER O PONTO M�XIMO DA CONVOLU��O
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(sind)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % ESCOLHER DE ACORDO COM O CONHECIMENTO ANAL�GICO
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmp(mod,'CONV');        
        if base.uniform == 1
            Nmax{i} = convCHOICE(data,SHAPE_VALID,SHAPE_ANALOG,sind{i},base);
        else
            Nmax(i) = convCHOICE(data,SHAPE_VALID,SHAPE_ANALOG,sind{i},base);
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % ESCOLHER DE ACORDO COM O MSE DOS DADOS EM RELA��O AO SHAPE DE
    % TREINAMENTO
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmp(mod,'MSE');
        if base.real == 0
            if base.uniform == 1
                Nmax{i} = convMSE(data,SHAPE_TRAIN(sind{i}),base);
            else
                Nmax(i) = convMSE(data,SHAPE_TRAIN(sind{i}),base);
            end
        else
            Nmax{i} = convMSE(data,SHAPE_TRAIN(sind{i}),base);            
        end
        %         disp(num2str([Nmax2(i) Nmax(i)]))
    end
    
end

end