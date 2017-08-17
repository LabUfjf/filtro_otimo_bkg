function [ Rxx ] = MeanSpectrumPower( x )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fun��o para calculo do Espetro de Pot�ncia M�dio do Ru�do              %
% Inputs:                                                                 %
%        x - Matriz de ru�do NxM | N-> Amostras e M->Aquisi��es           %
%                                                                         %
% Outputs:                                                                %
%        mean_cov_x_shift - M�dia do Espectro de Pot�ncia                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
corr_x=corr(x');
[a,~]=size(corr_x);

for j=0:(a-1);
    for i=1:(a-j)
        teste2(i) = corr_x(i+(j), i);
        teste4(i) = corr_x(i, i+(j));
    end
    teste3{j+1}=teste2;
    teste5{j+1}=teste4;
    clear teste2 teste4;
end

for k=1:a
    corr_media1(k)=mean(teste3{k});
    corr_media2(k)=mean(teste5{k});
end

Rxx=[corr_media2(a-(0:(a-1))) corr_media1(2:end)];
figure
subplot(2,1,1)
plot(Rxx)

subplot(2,1,2)
eixo_x=linspace(1,hertz,length(Rxx));
plot(eixo_x, 20*log10(abs(fft(TEST2))));
