function [y] = GETSHAPE_FE(N)
% Função cria shape Front-End com 'N' pontos
% N é o número de pontos desejado

x = ones(1,N);
aux=0;
for i=2:N
    aux = aux + 170/N;
    x(i) = aux;
end

a1 =      0.4254; 
b1 =       49.36;
c1 =       7.993;
a2 =      0.4281;
b2 =       57.53;
c2 =       10.72;
a3 =      0.2632;
b3 =       42.73;
c3 =       5.921;
a4 =      0.3832;
b4 =       67.27; 
c4 =       15.33; 
a5 =      0.2378; 
b5 =       81.85; 
c5 =       22.36;
a6 =      0.1035;
b6 =       91.21;
c6 =       46.54;

y = a1*exp(-((x-b1)/c1).^2) + a2*exp(-((x-b2)/c2).^2) + ...
    a3*exp(-((x-b3)/c3).^2) + a4*exp(-((x-b4)/c4).^2) + ...
    a5*exp(-((x-b5)/c5).^2) + a6*exp(-((x-b6)/c6).^2);
