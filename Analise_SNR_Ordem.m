function [SR,E,out] = Analise_SNR_Ordem(S,Noise,CF,base,TRUTH,Nmax)

if strcmp(base.EST,'AMPLITUDE');
    S = S*1e3;
    Noise = Noise*1e3;
    TRUTH_kind = TRUTH.A*1e3;
else
    TRUTH_kind = TRUTH.F;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  APLICANDO FILTRO NO SINAL E RUÍDO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ordem = base.ordem;

wait = waitbar(0,'Order');
for i=1:length(ordem)
    
    for j = 1:6
        if base.real == 0
            if base.uniform == 1
                if strcmp(base.EST,'AMPLITUDE');
                    [SNRF(i,j),out.filter{i}(j,:),STD_SNR(i,j),STD(i,j)] = applyfilter(CF.A{j}{i},S,Noise,Nmax{i},base);
                else
                    [SNRF(i,j),out.filter{i}(j,:),STD_SNR(i,j),STD(i,j)] = applyfilter(CF.F{j}{i},S,Noise,Nmax{i},base);
                    [~,OUTA{i}(j,:),~,~] = applyfilter(CF.A{j}{i},S,Noise,Nmax{i},base);
                end
            else
                if strcmp(base.EST,'AMPLITUDE');
                    [SNRF(i,j),out.filter{i}(j,:),STD_SNR(i,j),STD(i,j)] = applyfilter(CF.A{j}{i},S,Noise,Nmax(i),base);
                else
                    [SNRF(i,j),out.filter{i}(j,:),STD_SNR(i,j),STD(i,j)] = applyfilter(CF.F{j}{i},S,Noise,Nmax(i),base);
                    [~,OUTA{i}(j,:),~,~] = applyfilter(CF.A{j}{i},S,Noise,Nmax(i),base);
                end
            end
        else
            if strcmp(base.EST,'AMPLITUDE');
                %                 save test CF S Noise Nmax base
                %                 pause
                [SNRF(i,j),out.filter{i}(j,:),STD_SNR(i,j),STD(i,j)] = applyfilter(CF.A{j}{i},S,Noise,Nmax(i),base);
            else
                [SNRF(i,j),out.filter{i}(j,:),STD_SNR(i,j),STD(i,j)] = applyfilter(CF.F{j}{i},S,Noise,Nmax(i),base);
                [~,OUTA{i}(j,:),~,~] = applyfilter(CF.A{j}{i},S,Noise,Nmax(i),base);
            end
        end
        
    end
    %     figure(99)
    %     hold on
    %     legend('NO RESTRICTION','PHASE','PHASE(2Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)','Location', 'Best')
    %     pause
    
    if base.real == 0
        if strcmp(base.EST,'AMPLITUDE');
            FILTRADO = out.filter{i};
        else
            FILTRADO = -out.filter{i}./OUTA{i};
            %             FILTRADO = OUTA{i};
        end
        [EST(i,:),EST_STD(i,:)]= calcEST(TRUTH_kind,FILTRADO); %ESTIMAÇÃO Amplitude ATRUTH-AEST
    end
    waitbar(i/length(ordem))
    
end
close(wait)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ORGANIZANDO VARIÁVEIS DE SAÍDA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nmax(1)
% round(size(S,1)/2)
% figure
% hist(TRUTH_kind-S(round(size(S,1)/2),:),500)
% pause

out.base = S(round(size(S,1)/2),:);
out.STD.filter = STD;

if base.error == 1
    out.STD.base = std(out.base)/sqrt(length(out.base));
else
    out.STD.base = std(out.base);
end

out.truth = TRUTH_kind;
[SNR_BASE,STD_SNR_BASE] = SNR(out.base, Noise,base);

if base.real == 0
    EST_BASE = TRUTH_kind-S(round(size(S,1)/2),:);
    if base.error == 1
        EST_STD_BAS = std(EST_BASE)/sqrt(length(EST_BASE));
    else
        EST_STD_BAS = std(EST_BASE);
    end
    
end

% SINAL\RUÍDO
SR.filter = SNRF;
SR.base = SNR_BASE;
SR.STD.filter = STD_SNR;
SR.STD.base = STD_SNR_BASE;

% ESTIMAÇÃO
if base.real == 0
    E.filter = EST;
    E.base = mean(EST_BASE);
    E.STD.filter = EST_STD;
    E.STD.base = EST_STD_BAS;
else
    E = 0;
end

end