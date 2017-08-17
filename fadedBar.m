function fadedBar( h, errstd )
%FADEDBAR - add faded error markers to bar chart
%   Useful instead of error bars to give a visual fix on error
%   h - handle to bar char object
%   errstd - the standard deviation of the errors (assumes Gaussian error)
%
%   by Malcolm McLean, Weizmann Institute of Science, Israel
%
    xvals = get(h, 'XData');
    yvals = get(h, 'YData');
    wd = get(h, 'BarWidth');
    ylim = get(gca, 'YLim');
    
    % get the colour of the bars, and convert to 8-bit rgb triplets
    fg = get(h, 'FaceColor');
    if(strcmp(fg, 'flat'))
        cmap = get(gcf, 'Colormap');
        fg = cmap(1, :);
        fg = uint8(fg * 255);
    else
        fg = colordeftotriplet(fg);
    end
    
    % get background colour, and do the same
    bg = get(gca, 'Color');
    bg = colordeftotriplet(bg);
    
    % get the sizes of the patches we will create
    [patchwidth patchheight] = getpatchsize(errstd);
    
    % add error patches to the bar chart
    for ii = 1: length(xvals);
        if(patchheight(ii) < 1)
            continue;
        end
        fade = errorpatch(patchwidth(ii), patchheight(ii), fg, bg);
        hold on;
        ybottom = yvals(ii) - errstd(ii) * 3;
        if(ybottom < 0 && ylim(1) == 0)
            newy = floor(abs(ybottom) / (errstd(ii) * 6) * patchheight(ii)) + 1;
            ybottom = 0.0;
            fade = fade(newy:patchheight(ii), :, :);
        end
        image([xvals(ii) - wd/2 xvals(ii) + wd/2], ...
            [ybottom yvals(ii) + errstd(ii) * 3], ...
            fade);
    end
    
end

%
% Draw the error patch. It's a 24-bit rgb image, with pixels faded out 
%   with a Gaussian function.
%
function C = errorpatch(width, height, fg, bg)
  C = zeros(height, width, 3, 'uint8');
  C(:,:,1) = bg(1);
  C(:,:,2) = bg(2);
  C(:,:,3) = bg(3);
  rnd = randn(height, width);
  for ii = 1: height
    evalue = ii/height * 6 - 3;
    for jj = 1: width
        if(evalue < rnd(ii,jj))
            C(ii,jj,1) = fg(1);
            C(ii,jj,2) = fg(2);
            C(ii,jj,3) = fg(3);
        end
    end
  end
end

%
% Get the width and height of the patch, in pixels
% The function doesn't need to be exact, just to get the size approximately
%  right so that all the pixellation looks about the same size
%
function [width height] = getpatchsize(errstd)
    t = get(gca, 'Units');
    set(gca, 'Units', 'pixels');
    axessize = get(gca, 'Position');
    set(gca, 'Units', t);
    ylim = get(gca, 'YLim');
    yrange = abs(ylim(1) - ylim(2)) + max(errstd) * 3;
    for ii = 1: length(errstd)
        width(ii) = floor(axessize(3)/length(errstd));
        height(ii) = floor(axessize(4)/yrange * errstd(ii) * 3);
    end
    
end

%
% Convenience fucntion. Convert a colorspec to an 8-bit rgb triplet
%
function rgb8 = colordeftotriplet(cd)
  if(isnumeric(cd))
      rgb8 = uint8(cd * 255);
  else
      switch(cd)
          case 'red'
              rgb8 = uint8([255 0 0]);
          case 'r'
              rgb8 = uint8([255 0 0]);
          case 'green'
              rgb8 = uint8([0 255 0]);
          case 'g'
              rgb8 = uint8([0 255 0]);
          case 'blue'
              rgb8 = uint8([0 0 255]);
          case 'b'
              rgb8 = uint8([0 0 255]);
          case 'yellow'
              rgb8 = uint8([255 255 0]);
          case 'y'
              rgb8 = uint8([255 255 0]);
          case 'cyan'
              rgb8 = uint8([0 255 255]);
          case 'c'
              rgb8 = uint8([0 255 255]);
          case' magenta'
              rgb8 = uint8([255 0 255]);
          case 'm'
              rgb8 = uint8([255 0 255]);
          case 'white'
              rgb8 = uint8([255 255 255]);
          case 'w'
              rgb8 = uint8([255 255 255]);
          case 'black'
              rgb8 = uint8([0 0 0]);
          case 'k'
              rgb8 = uint8([0 0 0]);
          otherwise
              rgb8 = uint8([0 0 0]);
      end
  end
end