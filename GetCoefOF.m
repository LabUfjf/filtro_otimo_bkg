function [CF] = GetCoefOF(Noise, ordem, s, g, DiffType, type,doRij,doPlot,setup,test)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULAR COEFICIENTES DOS FILTROS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRI��O:
%           Esta fun��o retorna os coeficientes dos filtros �timo, para 5
%           modalidade de filtros.
% ENTRADAS:
%          Noise = matriz de ru�do
%          ordem = vetor contendo a ordem dos filtros
%          s     = Forma de onda do sinal com todas amostras e sem ruido
%          (Sinal Total si)
%          g     = pontos da forma de onda de interesse
%          DiffType = seleciona o m�todo de derivada
%          type = seleciona o shape (1=front-end; 0=gaussiano)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% C�LCULO DA MATRIZ DE AUTOCORRELA��O POR 3 M�TODOS:
% 3 M�TODOS DIFERENTES:
% 1- MATRIZ IDENTIDADE
% 2- UTILIZAR MATRIZ DE CORRELA��O
% 3- UTILIZAR A M�DIA DA MATRIZ DE CORRELA��O
[~, NC] = size(Noise); Rij=corr(Noise);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(doRij,'Identity');
    Rij = eye(length(Rij));
end
if strcmp(doRij,'Normal');
    Rij=corr(Noise);
end
if strcmp(doRij,'Mean');
    Rij = RijNaN( Rij);
end
% figure
% mesh(Rij); axis tight

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INICIAR VARI�VEIS DOS COEFICIENTES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u.sr      = cell(1,length(ordem)); % Coeficientes do Filtro SEM restri��o
u.rf      = cell(1,length(ordem)); % Coeficientes do Filtro Com restri��o de defasagem
u.rf2     = cell(1,length(ordem)); % Coeficientes do Filtro Com restri��o de defasagem 1� e 2� derivadas
u.rp      = cell(1,length(ordem)); % Coeficientes do Filtro Com restri��o de pedestal
u.rpf     = cell(1,length(ordem)); % Coeficientes do Filtro Com restri��o de pedestal e defasagem
u.rpf2    = cell(1,length(ordem)); % Coeficientes do Filtro Com restri��o de pedestal e defasagem 1� e 2� derivadas

v.sr      = cell(1,length(ordem)); % Coeficientes do Filtro SEM restri��o
v.rf      = cell(1,length(ordem)); % Coeficientes do Filtro Com restri��o de defasagem
v.rf2     = cell(1,length(ordem)); % Coeficientes do Filtro Com restri��o de defasagem 1� e 2� derivadas
v.rp      = cell(1,length(ordem)); % Coeficientes do Filtro Com restri��o de pedestal
v.rpf     = cell(1,length(ordem)); % Coeficientes do Filtro Com restri��o de pedestal e defasagem
v.rpf2    = cell(1,length(ordem)); % Coeficientes do Filtro Com restri��o de pedestal e defasagem 1� e 2� derivadas

for i=1:length(ordem)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % FILTRO SEM RESTRI��O = A0
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear A B SA SF C;
    A = [Rij(1:ordem(i),1:ordem(i))  s(g{i})'
        s(g{i})                 zeros(1,1)];
    B = [zeros(1,ordem(i))   1]';
    C = [zeros(1,ordem(i))   0]';
    SA = linsolve(A,B);
    SF = linsolve(A,C);
    
    if setup.QuantCoef == 1
        SA = ApplyResolution(SA, test.bits, setup);
        SF = ApplyResolution(SA, test.bits, setup);
    end
    
    u.sr{i} = SA(1:ordem(i));        % Coeficientes do Filtro SEM restri��o
    v.sr{i} = SF(1:ordem(i));
    
    gL{1}{i}=NaN*ones(1,ordem(i));
    gL2{1}{i}=NaN*ones(1,ordem(i));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % FILTRO COM RESTRI��O DE FASE = A1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear A B SA SF C;
    if(DiffType==1)
        gL{2}{i} = diff([s(g{i}) s(g{i}(length(g{i})))]);
    else
        gL{2}{i} = Derivada2(g{i}, type, s, NC);
    end
    
    A = [Rij(1:ordem(i),1:ordem(i))  s(g{i})'      gL{2}{i}'
        s(g{i})                   zeros(1,2)
        gL{2}{i}                  zeros(1,2)      ];
    B = [zeros(1,ordem(i))   1   0]';
    C = [zeros(1,ordem(i))   0   -1]';
    SA = linsolve(A,B);
    SF = linsolve(A,C);
    
    if setup.QuantCoef == 1
        SA = ApplyResolution(SA, test.bits, setup);
        SF = ApplyResolution(SA, test.bits, setup);
    end
    
    u.rf{i} = SA(1:ordem(i));       % Coeficientes do Filtro Com restri��o de defasagem
    v.rf{i} = SF(1:ordem(i));
    
    gL2{2}{i}=NaN*ones(1,ordem(i));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % FILTRO COM RESTRI��O DE FASE (1� E 2 DERIVADA) = A2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear A B SA SF C;
    
    if(DiffType==1)
        gL{3}{i}  = diff([s(g{i}) s(g{i}(length(g{i})))]);
        gL2{3}{i} = diff(diff([s(g{i}) s(g{i}(length(g{i})))  s(g{i}(length(g{i})))]));
    else
        gL{3}{i}  = Derivada2(g{i}, type, s, NC);
        gL2{3}{i} = SegundaDerivada(g{i}, type, s, NC);
    end
    
    A = [Rij(1:ordem(i),1:ordem(i))  s(g{i})'      gL{3}{i}'  gL2{3}{i}'
        s(g{i})                   zeros(1,3)
        gL{3}{i}                  zeros(1,3)
        gL2{3}{i}                 zeros(1,3)      ];
    
    B = [zeros(1,ordem(i))   1   0  0]';
    C = [zeros(1,ordem(i))   0   -1  0]';
    SA = linsolve(A,B);
    SF = linsolve(A,C);
    
    if setup.QuantCoef == 1
        SA = ApplyResolution(SA, test.bits, setup);
        SF = ApplyResolution(SA, test.bits, setup);
    end
    
    u.rf2{i} = SA(1:ordem(i));     % Coeficientes do Filtro Com restri��o de defasagem 1� e 2� derivadas
    v.rf2{i} = SF(1:ordem(i));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % FILTRO COM RESTRI��O DE PEDESTAL = A3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear A B SA SF C;
    A = [Rij(1:ordem(i),1:ordem(i))  s(g{i})'      ones(1,length(g{i}))'
        s(g{i})                   zeros(1,2)
        ones(1,length(g{i}))      zeros(1,2)                        ];
    B = [zeros(1,ordem(i))   1   0]';
    C = [zeros(1,ordem(i))   0   0]';
    SA = linsolve(A,B);
    SF = linsolve(A,C);
    
    if setup.QuantCoef == 1
        SA = ApplyResolution(SA, test.bits, setup);
        SF = ApplyResolution(SA, test.bits, setup);
    end
    
    u.rp{i} = SA(1:ordem(i));       % Coeficientes do Filtro Com restri��o de pedestal
    v.rp{i} = SF(1:ordem(i));
    gL{4}{i}=NaN*ones(1,ordem(i));
    gL2{4}{i}=NaN*ones(1,ordem(i));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % FILTRO COM RESTRI��O DE PEDESAL E FASE = A4
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear A B SA SF C;
    if(DiffType==1)
        gL{5}{i} = diff([s(g{i}) s(g{i}(length(g{i})))]);
    else
        gL{5}{i} = Derivada2(g{i}, type, s, NC);
    end
    A = [Rij(1:ordem(i),1:ordem(i))  s(g{i})'     gL{5}{i}'  ones(1,length(g{i}))'
        s(g{i})                   zeros(1,3)
        gL{5}{i}                  zeros(1,3)
        ones(1,length(g{i}))      zeros(1,3)                        ];
    B = [zeros(1,ordem(i))   1   0   0]';
    C = [zeros(1,ordem(i))   0   -1   0]';
    SA = linsolve(A,B);
    SF = linsolve(A,C);
    
    if setup.QuantCoef == 1
        SA = ApplyResolution(SA, test.bits, setup);
        SF = ApplyResolution(SA, test.bits, setup);
    end
    
    u.rpf{i} = SA(1:ordem(i));       % Coeficientes do Filtro Com restri��o de pedestal e defasagem
    v.rpf{i} = SF(1:ordem(i));
    gL2{5}{i}=NaN*ones(1,ordem(i));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % FILTRO COM RESTRI��O DE FASE E PEDESTAL(1� E 2 DERIVADA)= A5
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear A B SA SF C;
    if(DiffType==1)
        gL{6}{i}  = diff([s(g{i}) s(g{i}(length(g{i})))]);
        gL2{6}{i} = diff(diff([s(g{i}) s(g{i}(length(g{i})))  s(g{i}(length(g{i})))]));
    else
        gL{6}{i}  = Derivada2(g{i}, type, s, NC);
        gL2{6}{i} = SegundaDerivada(g{i}, type, s, NC);
    end
    A = [Rij(1:ordem(i),1:ordem(i))  s(g{i})'     gL{6}{i}'  gL2{6}{i}' ones(1,length(g{i}))'
        s(g{i})                   zeros(1,4)
        gL{6}{i}                  zeros(1,4)
        gL2{6}{i}                 zeros(1,4)
        ones(1,length(g{i}))      zeros(1,4)                        ];
    B = [zeros(1,ordem(i))   1   0   0  0]';
    C = [zeros(1,ordem(i))   0   -1   0  0]';
    SA = linsolve(A,B);
    SF = linsolve(A,C);
    
    if setup.QuantCoef == 1
        SA = ApplyResolution(SA, test.bits, setup);
        SF = ApplyResolution(SA, test.bits, setup);
    end
    
    u.rpf2{i} = SA(1:ordem(i));       % Coeficientes do Filtro Com restri��o de pedestal e defasagem 1� e 2� derivadas
    v.rpf2{i} = SF(1:ordem(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ORGANIZAR COEFICIENTES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CF.A = [{u.sr} {u.rf} {u.rf2} {u.rp} {u.rpf} {u.rpf2}];
CF.F = [{v.sr} {v.rf} {v.rf2} {v.rp} {v.rpf} {v.rpf2}];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT DO DEBUG DAS RESTRI��ES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if doPlot.COEF == 1
    COEFdebug(CF.A,s,g,gL,gL2,ordem)
    %     COEFdebug(CF.F,s,g,gL,gL2,ordem)
    pause
end



