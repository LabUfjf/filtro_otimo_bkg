function [sg] = doShape(sg,samples,phase,doPlot)
format long

base = 128; % 8ns entre amostras de sinal
f = base/samples;

[d,fn] = fixPeak(sg.ShapeFE,doPlot,f);
VA = [1:f:128]+d;

sg.shape = sg.ShapeFE(VA); sg.shape = [sg.shape; sg.shape(end)*ones(round(1/f)-1,1)];
sg.shape = sg.shape/fn;
sg.phase = sg.ShapeFE(VA+phase*f); sg.phase = [sg.phase; sg.phase(end)*ones(round(1/f)-1,1)];

sg.phase = sg.phase/fn;
% plot(sg.phase,'.')
% hold on
% pause
if doPlot == 1
    plot(VA,sg.shape(1:length(VA)),'ok'); hold on
    plot(VA+phase,sg.phase(1:length(VA)),'+b');
    legend('Shape fit','Shape Disc','Shape Disc_{Phase}')
    axis tight
end

center = round(samples/2);
[~,ims]=max(sg.shape);
[~,imp]=max(sg.phase);
sg.shape = circshift(sg.shape,center-ims);
sg.phase = circshift(sg.phase,center-imp);

% figure
% plot(sg.shape,'ok');hold on
% plot(sg.phase,'+b');hold on
% pause

end