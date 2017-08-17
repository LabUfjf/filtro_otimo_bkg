
function [t] = timeGen(t0,F,n) 

W=1024e-9;

t=exprnd(1/F,n,1);
t = t0+t;
t = t(t<W);

end