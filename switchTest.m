function [test]=switchTest(test,base)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAMETROS INICIAIS:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test.amostras = [128];                        %(T1) NÚMERO DE AMOSTRAS NO TEMPO
test.phase    = 11;                           %(T2) 11 = FASE ZERO
test.Pedestal = 0e-3;                         %(T3) PEDESTAL
test.NF       = 1;     %2.05 %1.02            %(T4) FATOR MULTIPLICATIVO DA VARIÂNCIA DO RUÍDO
test.bits     = [10];                         %(T5) NÚMERO DE BITS ADC
test.pileup     = [0];                        %(T5) NÚMERO DE BITS ADC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f = 128/test.amostras;
test.tau      = linspace(-1,1,21)*(f*8e-9);       % DEFASEGEM NO TEMPO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx')
disp('         SETUP(DEFAULT)          ')
disp('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx')
disp(['SAMPLES   = ' num2str(test.amostras)])
disp(['PHASE     = ' num2str(test.tau(test.phase))])
disp(['PEDESTAL  = ' num2str(test.Pedestal)])
disp(['NOISE FCT = ' num2str(test.NF)])
disp(['BITS      = ' num2str(test.bits)])
disp('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx')

switch(test.variable)
    case 'default'
        test.Xlabel='Order';
        test.Xtick= base.ordem;
    case 'amostras'
        test.amostras = base.ordem;
        test.Xlabel='Samples';
        test.Xtick=[64 128];
    case 'phase'
        test.phase = 1:21;
        test.Xlabel='Phase';
        test.Xtick=linspace(-3.14,3.14,21);
    case 'pedestal'
        test.Pedestal = linspace(0,30,20)*1E-3;
        test.Xlabel='Pedestal (mV)';
        test.Xtick=test.Pedestal*1E3 ;
    case 'NF'
        test.NF    = linspace(1,10,20);
        test.Xlabel='Noise Factor';
        test.Xtick = linspace(1,10,20);
    case 'bits'
        test.bits   = [8:2:32];
        test.Xlabel = 'Bits';
        test.Xtick  = test.bits;
    case 'pileup'
%       test.pileup = 8e3;
        test.pileup = [linspace(1,10e3,30)];
        test.Xlabel ='Events Frequency';
        test.Xtick  = test.pileup;
end

end