function cropped_line_img = lineSegmentFinder(orig_img, hough_img, hough_threshold)
    fig = figure();
    imshow(orig_img);
    edge_img = im2double(edge(orig_img));

	% --------------------------------------
	% START ADDING YOUR CODE HERE
	% --------------------------------------
    
    [H, W] = size(orig_img);
    D = sqrt(H^2 + W^2);
    [N_rho, N_theta] = size(hough_img);
	
	% You'd want to change this.	
	strong_hough_img = hough_img;
	
    for i = 1:N_rho
        for j = 1:N_theta
            if strong_hough_img(i, j) >= hough_threshold
            	% map to corresponding line parameters 
            	rho = (i-0.5) * 2*D / N_rho - D;
                theta = pi / N_theta * (j - 0.5);
                % disp([rho, theta])
            	% generate some points for the line
            	
            	% and draw on the figure
                drawlineSeg(rho, theta, W, H, edge_img);
            	% ('hold on;' and call the line() function).
            end
        end
    end
    
    % ---------------------------
    % END YOUR CODE HERE    
    % ---------------------------

    % provided in demoMATLABTricksFun.m
    cropped_line_img = saveAnnotatedImg(fig);
    close(fig);
end

function drawlineSeg(rho, theta, W, H, edge_img)
    % x0 = 0;
    % y0 = rho / cos(theta);
    % disp(y0);
    % x1 = W;
    % y1 = (rho - x1 * sin(theta)) / cos(theta);
    pixel_indicator = zeros(1, W);
    for x = 1: W
        y = round((rho - x * sin(theta)) / cos(theta));
        if (1 <= y) && (y <= H) 
            if edge_img(y, x) > 0
                pixel_indicator(x) = 1;
            end
        end
    end
    % pixel_indicator
    f = find(diff([0,pixel_indicator,0]==1));
    if isempty(f)
        return
    end
    f_rev = [];
    
    i = 1;
    while i <= (length(f)-1)
        if (f(i+1) - f(i) < 5) && (pixel_indicator(f(i)) == 0)
            i = i + 2;
        else
            f_rev = [f_rev, f(i)];
            i = i + 1;
        end 
    end
    f_rev = [f_rev, f(end)];


    s = f_rev(1:2:end-1);  % Start indices
    c = f_rev(2:2:end)-s;
    for i = 1:length(s)
        start_x = s(i);
        start_y = round((rho - start_x * sin(theta)) / cos(theta));
        end_x = s(i) + c(i);
        end_y = round((rho - end_x * sin(theta)) / cos(theta));
        hold on; line([start_x, end_x], [start_y, end_y], 'LineWidth',1, 'Color', [0, 1, 0]);
    end
    
end

function annotated_img = saveAnnotatedImg(fh)
    figure(fh); % Shift the focus back to the figure fh
    
    % The figure needs to be undocked
    set(fh, 'WindowStyle', 'normal');
    
    % The following two lines just to make the figure true size to the
    % displayed image. The reason will become clear later.
    img = getimage(fh);
    truesize(fh, [size(img, 1), size(img, 2)]);
    
    % getframe does a screen capture of the figure window, as a result, the
    % displayed figure has to be in true size. 
    frame = getframe(fh);
    frame = getframe(fh);
    pause(0.5); 
    % Because getframe tries to perform a screen capture. it somehow 
    % has some platform depend issues. we should calling
    % getframe twice in a row and adding a pause afterwards make getframe work
    % as expected. This is just a walkaround. 
    annotated_img = frame.cdata;
end