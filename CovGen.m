function [base] = CovGen(setup,mod)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gerar matriz de correlaç
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d = setup.samples;
t = setup.time;
xc = linspace(t(1),t(2),d); % eixo de tempo

if strcmp(mod,'ANALOG');
    
    
    
    a = 1;
    c = (1/setup.Tesc)*0.5e-1;
    xe = linspace(-t(2),t(1),d);
    xd = linspace(t(1),2*t(2),d);
    x = [xe(1:end-1) xc xd(2:end)];
    
    eq= a*exp(c*x(1:ceil(end/2)));
    eq = (eq/max(eq));
    eq = [eq(1:end-1) fliplr(eq)];
    
    M=zeros(d,d);
    
    for i = 1:d
        C=circshift(eq',floor(length(eq)/2)+i);
        M(i,:)= C(1:d);
    end
    base.x = xc;
    base.M = M;
end

if strcmp(mod,'IDENTITY');
    base.x = xc;
    base.M = eye(d);
end
% figure
% mesh(M)
% axis tight
end