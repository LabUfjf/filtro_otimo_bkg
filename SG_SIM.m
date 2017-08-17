function [signal] = resample_SG(sg,A)

S = 8e-09;
F = A/S;
VA = 1:F:128;
signal = sg.ShapeFE(VA)/max(sg.ShapeFE(VA)); signal = [signal; signal(end)*ones(round(1/F)-1,1)];
plot(sg.ShapeFE(VA))

end