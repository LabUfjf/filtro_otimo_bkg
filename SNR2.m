function [y,mu,sigma] = SNR2(Signal, SigmaNoise)
% Fun��o calcula a Signal-to-noise ratio (SNR)
% Signal -> Sinal Filtrado onde obteremos a m�dia do valor de pico
% SigmaNoise -> desvio padr�o do ru�do

Pico = max(Signal');
[muhat,sigmahat] = normfit(Pico);
mu = mean(muhat);
sigma = mean(sigmahat);

y = 10*log10(mu/SigmaNoise);