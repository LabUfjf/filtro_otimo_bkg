function [Shape] = ShapeFunction(N, Dx, type,Ns)
% Função cria shape Gaussiano com 'N' pontos
% N é o número de pontos desejado
% Dx fase
% Define se o shape é gaussiano ou front-end signal

x = zeros(1,N);
aux=0;

if(type==1) % Front-End
    
    for i=1:N
        step = 30/N;
        aux = aux + step;
        x(i) = aux + Dx*step;
    end
    
  

    x = x - 0.661;    % centralizar fase zero
    a1 =      0.3507;
    b1 =       13.51;
    c1 =       5.701;
    a2 =      0.2791;
    b2 =       6.179;
    c2 =       1.221;
    a3 =         0.5;
    b3 =       7.744;
    c3 =       1.828;
    a4 =   -0.009263;
    b4 =      -4.053;
    c4 =       12.77;
    a5 =           0;
    b5 =      -3.623;
    c5 =      0.7754;
    a6 =      0.5386;
    b6 =       10.02;
    c6 =       3.029;

y = a1*exp(-((x-b1)/c1).^2) + a2*exp(-((x-b2)/c2).^2) + ...
    a3*exp(-((x-b3)/c3).^2) + a4*exp(-((x-b4)/c4).^2) + ...
    a5*exp(-((x-b5)/c5).^2) + a6*exp(-((x-b6)/c6).^2);

y = y/1.00820559167374;  % normalizar
y(1:2) = 0;              % remover pontos negativos no shape

% -------------------------------------------------------------------------
else        % Gaussiano
    
   for i=1:N
        step = 30/N;
        aux = aux + step;
        x(i) = aux + Dx*step;
   end
    a1 =           1;
    b1 =          15;
    c1 =       5.303;
    y = a1.*exp(-((x-b1)./c1).^2);
    
end

no = round(Ns*(1/5));
Shape = [zeros(1,no) y zeros(1,Ns-no-length(y))];