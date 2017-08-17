function [fitresult, gof] = fitShapeFE(x, y, doPlot)
%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'gauss6' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0];
opts.StartPoint = [1 65 0.622084021112877 0.914392588830108 64 0.782460381955268 0.874879463216941 66 0.762143847948972 0.765567379576225 68 0.857627156970965 0.721151874607156 63 1.22229713963756 0.554615702930242 70 0.984964193170478];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

if doPlot == 1
% Plot fit with data.
figure( 'Name', 'untitled fit 2' );
h = plot( fitresult, xData, yData );
legend( h, 'y1 vs. x', 'untitled fit 2', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y1
grid on
end

