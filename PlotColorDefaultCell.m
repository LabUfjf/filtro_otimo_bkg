function PlotColorDefaultCell( X,Y,xl,yl)

% markface = [{[1 1 1]},{[1 1 1]},{[1 1 1]},{[0 0 0]},{[0 0 1]},{[1 0 0]},{[1 0 0]}];
% mark = [{'o'},{'^'},{'s'},{'o'},{'^'},{'s'},{'none'}];
% cor = [{[0 0 0]},{[0 0 1]},{[1 0 0]},{[0 0 0]},{[0 0 0]},{[0 0 0]},{[1 0 0]}];
% % lstyle = [{':'},{':'},{':'},{':'},{':'},{':'},{':'}];
% lstyle = [{'none'},{'none'},{'none'},{'none'},{'none'},{'none'},{':'}];
    markface = [{[1 1 1]},{[1 1 1]},{[1 1 1]},{[0 0 0]},{[0.501960813999176 0.501960813999176 0.501960813999176]},{[0.831372559070587 0.815686285495758 0.7843137383461]},{[0 0 0]}];
    mark = [{'o'},{'^'},{'s'},{'o'},{'^'},{'s'},{['none']}];
    cor = [{[0 0 0]},{[0.501960813999176 0.501960813999176 0.501960813999176]},{[0.800000011920929 0.800000011920929 0.800000011920929]},{[0 0 0]},{[0.501960813999176 0.501960813999176 0.501960813999176]},{[0.800000011920929 0.800000011920929 0.800000011920929]},{[1 0 0]}];
    lstyle = [{':'},{':'},{':'},{'-'},{'-'},{'-'},{':'}];

for i = 1:length(Y)
    % Create multiple lines using matrix input to plot
    plot(X,Y{i},'MarkerFaceColor',markface{i},'Marker',mark{i},'Color',cor{i},'LineStyle',lstyle{i});
    hold on
end
% Create xlabel
xlabel({xl},'FontSize',16);
% Create ylabel
ylabel({yl},'FontSize',16);
axis tight
% Set the remaining axes properties
grid on
set(gca,'GridLineStyle',':');
set(gca,'fontsize',14)
legend({'AMPLITUDE','PHASE','PHASE(2Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)','BASE'},'FontSize',10, 'Location', 'Best')
