function [Digital_value] = ApplyResolution(Analog_value, Bits, setup)
Volts = setup.Volts;
% Esta fun��o aplica a resolu��o no processo realizado pelo ADC.
% Entradas:
% 'Analog_value' vetor a ser processado
% 'Bits' n�mero de bits do conversor (8 ou 10)
% 'Volts' � a tens�o de entrada do conversor;
% 'Fs' frequ�ncia de amostrage
if setup.Quant ==1
    vpb = Volts/(2^Bits-1); % Volts per Bit
    Digital_value = round(Analog_value./vpb).*vpb; % Quantised Analog input
else
    Digital_value = round(((2^(Bits - 1) - 1)*Analog_value));
end