function [SG,shape,A] = SGGen(setup,base,phase,BG)
x = base.x;
[shape] = Gauss(setup,x,phase);
% figure
% plot(shape.zero)
% pause

A = setup.A.mu+setup.A.var*randn(setup.N,1);
A = A(A>0);


SG=A.*ones(length(A),1)*shape.phase+BG(1:length(A),:);


end