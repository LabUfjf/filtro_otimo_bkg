function [C] = FilterCoef(change,OF)
order = change.order;

M = [OF.Rij OF.shape' OF.d1' OF.d2' OF.d3' ones(order,1);
    OF.shape zeros(1,5);    
    OF.d1 zeros(1,5);
    OF.d2 zeros(1,5);    
    OF.d3 zeros(1,5);
    ones(1,order) zeros(1,5)];

% MW = [OF.RW];

R.A = [zeros(1,change.order) 1 zeros(1,4)];
R.PH = [zeros(1,change.order) 0 -1 0 0 0];
% R.W = [OF.shape 0];
% R.A = [OF.shape 1 zeros(1,3)];
% R.PH = [OF.shape 0 -1 0 0];

% ind{1} = [1:order+1];
% ind{2} = [1:order+1 order+2];
% ind{3} = [1:order+1 order+3];
% ind{4} = [1:order+1 order+4];
% 
% ind{5} = [1:order+1 order+5];
% ind{6} = [1:order+1 order+2 order+5];
% ind{7} = [1:order+1 order+3 order+5];
% ind{8} = [1:order+1 order+4 order+5];

MC = [OF.Rij OF.shape';
    OF.shape 0];
d.A = [zeros(1,change.order) 1];
d.PH = [zeros(1,change.order) 0];

MA = [OF.d1' OF.d2' OF.d3' ones(order,1);
    zeros(1,4)]';

b.A = [zeros(1,4)];
b.PH = [-1 0 0 0];


ind{1} = [1:order+1];            % Coeficientes do Filtro SEM restrição
ind{2} = [1:order+2];            % Coeficientes do Filtro Com restrição de fase
ind{3} = [1:order+3];            % Coeficientes do Filtro Com restrição de fase 1ª e 2ª derivadas
% ind{4} = [1:order+4];            % Coeficientes do Filtro Com restrição de fase 1ª , 2ª e 3ª derivadas

ind{4} = [1:order+1 order+5];    % Coeficientes do Filtro Com restrição de pedestal
ind{5} = [1:order+2 order+5];    % Coeficientes do Filtro Com restrição de pedestal e fase
ind{6} = [1:order+3 order+5];    % Coeficientes do Filtro Com restrição de pedestal e fase 1ª e 2ª derivadas
% ind{8} = [1:order+4 order+5];    % Coeficientes do Filtro Com restrição de pedestal e fase 1ª , 2ª e 3ª derivadas

options = optimoptions('lsqlin','Algorithm','interior-point','Display','iter');
for i = 1:length(ind)
%     C.A{i} = inv(M(ind{i},ind{i})'*M(ind{i},ind{i}))*M(ind{i},ind{i})'*R.A(ind{i})';
%     C.PH{i} = inv(M(ind{i},ind{i})'*M(ind{i},ind{i}))*M(ind{i},ind{i})'*R.PH(ind{i})';
%     [C.A{i}] = lsmr(M(ind{i},ind{i})',R.A(ind{i})');
%     [C.PH{i}] = lsmr(M(ind{i},ind{i})',R.PH(ind{i})');
%     C.A{i} = lsqnonneg(M(ind{i},ind{i})',R.A(ind{i})');
%     C.PH{i} = lsqnonneg(M(ind{i},ind{i})',R.PH(ind{i})');
%     det(M(ind{i},ind{i}))
%     C.A{i} = gmres(M(ind{i},ind{i}),R.A(ind{i})');
%     C.PH{i} = gmres(M(ind{i},ind{i}),R.PH(ind{i})');  
%     opts.RECT = false;

 C.A{i} = lsqlin(M(ind{i},ind{i}),R.A(ind{i}),[],[]);
 C.PH{i} = lsqlin(M(ind{i},ind{i}),R.PH(ind{i}),[],[]);
%  C.A{i} = lsqlin(MC,d.A,MA,b.A,[],[],[],[],[],options);
%  C.PH{i} = lsqlin(MC,d.PH,MA,b.PH,[],[],[],[],[],options);

%     C.A{i} = linsolve(M(ind{i},ind{i}),R.A(ind{i})');
%     C.PH{i} = linsolve(M(ind{i},ind{i}),R.PH(ind{i})');   
    C.order.A{i}=C.A{i}(1:order);
    C.order.PH{i}=C.PH{i}(1:order);
end

% C.order.A{7}= inv(MW'*MW)*MW'*R.W;
% C.order.A{7} = linsolve(MW(ind{7},ind{7}),R.W(ind{7})');

end