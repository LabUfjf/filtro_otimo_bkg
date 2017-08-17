function [BG] = BGGen(setup,base,fct)
M = base.M;
BG = setup.bg.var*mvnrnd(zeros(length(M),1),M,setup.N);
BG = BG*fct;
end