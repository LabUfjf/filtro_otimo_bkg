function [fitresult, gof] = fitA2gauss(x, y, doPlot)
[xData, yData] = prepareCurveData( x, y );
% Set up fittype and options.
ft = fittype( 'gauss2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0 -Inf -Inf 0];
opts.StartPoint = [552 0.0716 0.00774480758016301 445.391133016997 0.0598666666666667 0.0103486088017762];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

if doPlot == 1
% Plot fit with data.
figure( 'Name', 'untitled fit 2' );
h = plot( fitresult, xData, yData );
legend( h, 'y vs. x', 'untitled fit 2', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y
grid on

end
