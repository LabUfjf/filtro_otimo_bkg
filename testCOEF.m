function []=testCOEF(test,NOISE_TRAIN, ordem, SHAPE_TRAIN, sind, DiffType, type, type_cov)

cor={'k';'r';'b';'c';'m';'g'};
wait = waitbar(0,'Test Coef');
k = 0;
for i= 1000:1000:length(NOISE_TRAIN)
    k = k+1;
    %% Arrumar c�digo
    %     size(NOISE_TRAIN)(test,Atruth,Noise, ordem, s, g, DiffType, type,doRij,doPlot)
    CF{k} = GetCoefOF(test,NOISE_TRAIN(:,1:i)', ordem, SHAPE_TRAIN', sind, DiffType, type, type_cov);  % CALCULA OS COEFICIENTES DOS FILTROS DE ACORDO COM A ORDEM
    %     save CF CF
    waitbar(i/length(NOISE_TRAIN))
    figure(999)
    if k > 1
        for j=1:6
            %         size((CF{1}{1}))
            %         CF{1}{1}(j)
            subplot(3,2,j); plot(i,abs(CF{k}{j}{end}-CF{k-1}{j}{end}),['o' cor{j}]); hold on ;grid on
            if j == 1
                title('Sem restri��o')
            end
            if j ==2
                title('Restri��o de fase (1� derivadas)')
            end
            if j == 3
                title('Restri��o de fase (1� e 2� derivadas)')
            end
            if j==4
                title('Restri��o de pedestal')
            end
            if j ==5
                title('Restri��o de pedestal e fase(1� derivadas)')
            end
            if j == 6
                title('Restri��o de pedestal e fase(1� e 2� derivadas)')
            end
        end
    end
    %     disp('----------------')
    %     pause
end
close(wait)
end

