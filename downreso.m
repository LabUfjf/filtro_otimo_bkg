function [ y ] =  downreso(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Função para setar o ruido com a mesma quantidade de amostras do sinal  %
% Inputs:                                                                 %
%        x - Matriz de ruído NxM | N-> Amostras e M->Aquisições           %
%        amostras - Quantidade de amostras                                %
% Outputs:                                                                %
%        y - Matriz de ruído NxM com N=Amostras                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y=x(1:2:2*amostras,:);

end

