function [setup] = parameters(A,var)
setup.Tesc = 1;
setup.Aesc = 1e-3;
setup.samples = A;
setup.time = [0 800]*setup.Tesc;
setup.bg.var = 2.05*setup.Aesc;
setup.N = 400000;
setup.sg.var = var*setup.Tesc;
setup.sg.mu = setup.time(2)/2;
setup.A.mu = 70*setup.Aesc;
setup.A.var = 10*setup.Aesc;

end