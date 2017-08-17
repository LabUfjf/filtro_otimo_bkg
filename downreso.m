function [ y ] =  downreso(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fun��o para setar o ruido com a mesma quantidade de amostras do sinal  %
% Inputs:                                                                 %
%        x - Matriz de ru�do NxM | N-> Amostras e M->Aquisi��es           %
%        amostras - Quantidade de amostras                                %
% Outputs:                                                                %
%        y - Matriz de ru�do NxM com N=Amostras                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y=x(1:2:2*amostras,:);

end

