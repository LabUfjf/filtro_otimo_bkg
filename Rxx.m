function [y] = Rxx(DATA)
% Função calcula função de autocorrelação


[NL,NC] = size(DATA);
y = zeros(NL,NC);
    for (i=1:NL)            % numero de linhas
       for (tau=0:(NC-1))   % numero de colunas (TAL)
          for (j=1:NC)      % numero de multiplicações
              if ((j+tau) > NC)
                  y(i,1+tau) = y(i,1+tau) + (DATA(i,j) * DATA(i,((j+tau)-NC)));
              else
                  y(i,1+tau) = y(i,1+tau) + (DATA(i,j) * DATA(i,j+tau)); 
              end           
          end
       end
    end

y = (1/(NC)) * y;