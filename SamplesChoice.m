function [OF] = SamplesChoice(base,TR,change)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MÉTODO  - ESTÁ SENDO UTILIZADO ATUALMENTE
%          SELECIONA AS AMOSTRAS DA MAIOR PARA A MENOR DE ACORDO COM SER
%          VALOR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,b]=sort(TR.shape.zero,'descend');
% [m] = find(TR.shape.zero==max(TR.shape.zero));
% b=m:1:length(TR.shape.zero);


b = b(1:change.order);
OF.ind=sort(b)';
OF.shape=TR.shape.zero(OF.ind);
OF.d1 = TR.shape.deriv.d1(OF.ind);
OF.d2 = TR.shape.deriv.d2(OF.ind);
OF.d3 = TR.shape.deriv.d3(OF.ind);

OF.Rij = base.M;
OF.Rij = OF.Rij(1:change.order,1:change.order);


end