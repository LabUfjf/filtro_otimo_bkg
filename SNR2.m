function [y,mu,sigma] = SNR2(Signal, SigmaNoise)
% Função calcula a Signal-to-noise ratio (SNR)
% Signal -> Sinal Filtrado onde obteremos a média do valor de pico
% SigmaNoise -> desvio padrão do ruído

Pico = max(Signal');
[muhat,sigmahat] = normfit(Pico);
mu = mean(muhat);
sigma = mean(sigmahat);

y = 10*log10(mu/SigmaNoise);