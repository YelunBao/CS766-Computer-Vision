function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)
    fig = figure();
    imshow(orig_img);

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
                drawline(rho, theta, W);
            	% ('hold on;' and call the line() function).
            end
        end
    end
    
    % ---------------------------
    % END YOUR CODE HERE    
    % ---------------------------

    % provided in demoMATLABTricksFun.m
    line_detected_img = saveAnnotatedImg(fig);
    close(fig);
end

function drawline(rho, theta, W)
    x0 = 0;
    y0 = round(rho / cos(theta));
    % disp(y0);
    x1 = W;
    y1 = round((rho - x1 * sin(theta)) / cos(theta));    
    hold on; line([x0, x1], [y0, y1], 'LineWidth',1, 'Color', [0, 1, 0]);
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