function [sg] = doShape_Uniforme(sg,samples,phase,doPlot)

format long
basesample = 128; % 8ns entre amostras de sinal
f = basesample/samples;
[d,fn] = fixPeak(sg.ShapeFE,doPlot,f);
VA = [1:f:128]+d;
sg.shape = sg.ShapeFE(VA); sg.shape = [sg.shape; sg.shape(end)*ones(round(1/f)-1,1)];
sg.shape = sg.shape/fn;

center = round(samples/2);

for i=1:length(phase)
    sg.phase = sg.ShapeFE(VA+phase(i)*f); 
    sg.phase = [sg.phase; sg.phase(end)*ones(round(1/f)-1,1)];
    [~,imp]=max(sg.phase);
    sg.phase = circshift(sg.phase,center-imp);
    sgphase(:,i) = sg.phase/fn;
end

% save Nmax Nmax
[~,ims]=max(sg.shape);
sg.shape = circshift(sg.shape,center-ims);
sg.phase = sgphase;
% plot(sg.shape,'ok');hold on
% plot(sg.phase,'+b');hold on
% pause
end