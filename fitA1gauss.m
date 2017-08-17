function [fitresult, gof] = fitA1gauss(x, y,doPlot)

%% Fit: 'untitled fit 3'.
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'gauss1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0];
opts.StartPoint = [552 0.0716 0.015489615160326];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

if doPlot == 1
% Plot fit with data.
figure( 'Name', 'untitled fit 3' );
save fitresult fitresult
plot(fitresult, xData, yData );
% legend( h, 'y vs. x', 'untitled fit 3', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y
grid on
% cftool(xData, yData)
% save testFit xData yData
end
