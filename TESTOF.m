function [INFO] = TESTOF(test,setup,base,doPlot)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNÇÃO PARA RODAR TODOS OS TESTES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i = 0;  tic;

progressbar('TEST SAMPLES','TEST PHASE','TEST PEDESTAL','TEST NOISE FACTOR','TEST BITS','TEST PILEUP') % WAITBAR COM 5 SEÇÕES

for iT1 = 1:length(test.amostras) % TESTE DE AMOSTRAS
    T1 = test.amostras(iT1);
    setup.res = setup.janela/T1;  % RESOLUÇÃO
    
    if strcmp(test.variable,'amostras');
        if length(base.ordem)>1
            base.ordem = 5:1:test.amostras(iT1)-1; % ALTERAR NO PLOT
        end
    end
    
    for iT2 = 1:length(test.phase) % TESTE DE FASES
        T2 = test.phase(iT2);
        
        [data.tr] = DataGen(setup.N.tr,T1,11,base); % CRIAR DADOS DE TREINAMENTO
        
        for iT3 = 1:length(test.Pedestal)   % TESTE DE PEDESTAL
            T3 = test.Pedestal(iT3);
            
            for iT4 = 1:length(test.NF)     % TESTE DE AUMENTO DE RUÍDO
                T4 = test.NF(iT4);
                
                for iT5 = 1:length(test.bits) % TESTE DE BITS
                    T5 = test.bits(iT5);
                    
                    if base.uniform == 1
                        [data.v] = DataGenUniform(setup.N.v,T1,base); % CRIAR DADOS DE VALIDAÇÃO - FASE UNIFORME.
                    else
                        [data.v] = DataGen(setup.N.v,T1,T2,base);   % CRIAR DADOS DE VALIDAÇÃO
                    end
                    
                    for iT6 = 1:length(test.pileup) % TESTE DE BITS
                        T6 = test.pileup(iT6);
                        i = i +1;
                        
                        if base.pileup ==1                           
                            [sg_pileup] = PileupADD(setup,test,T6,setup.N.v);
                            data.v.sg = data.v.sg+sg_pileup;
                            data.v.all = data.v.sg+data.v.bg;
                        end                        
                        
                        [data] = ModifyDataGen(data,T3,T4,setup,T5,doPlot.NDAQ); % APLICAR A RESOLUÇÃO NOS DADOS
                        [SR{i},EST{i},OUT{i},CF{i},sind] = OF(test,data,base,setup,doPlot);           % ESTIMAR AMPLITUDE COM FILTRO ÓTIMO
                        progressbar(iT1/length(test.amostras),iT2/length(test.phase),iT3/length(test.Pedestal),iT4/length(test.NF),iT5/length(test.bits),iT6/length(test.pileup)) % ATUALIZAÇÃO DAS 5 WAITBARS
                        
                    end
                end
            end
        end
        
        INFO.data = data;
        clear data
        
    end
end

progressbar(-1) % FINALIZAR WAITBAR

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONTAGEM DE TEMPO DO TESTE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = toc;
timestr = sec2timestr(time);
disp(['time TEST(' test.variable ')= ' timestr])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ORGANIZANDO SAÍDAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
INFO.SR=SR;
INFO.EST=EST;
INFO.OUT=OUT;
INFO.CF = CF;
INFO.sind = sind;
end