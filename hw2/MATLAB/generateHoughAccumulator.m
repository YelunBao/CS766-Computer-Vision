function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)
	% output array
    hough_img = zeros(rho_num_bins, theta_num_bins);
	
    [H, W] = size(img);
    D = sqrt(H^2 + W^2);
	% coordinate system
    [x, y] = meshgrid(1:W, 1:H);

    % ---------------------------
    % START ADDING YOUR CODE HERE
    % ---------------------------

    % YOU CAN MODIFY/REMOVE THE PART BELOW IF YOU WANT
    % ------------------------------------------------
    % here we assume origin = middle of image, not top-left corner
    % you can fix the top-left corner too (just remove the part below)
    % centre_x = floor(W/2);
    % centre_y = floor(H/2);
    % x = x - centre_x;
    % y = y - centre_y;
    % ------------------------------------------------

    % img is an edge image
    x_edge = x(img > 0);
    y_edge = y(img > 0);

    for i = 1:length(x_edge)
        x = x_edge(i);
        y = y_edge(i);
        % disp([x, y]);
        hough_img = hough_img + theta_rho_voter(x, y, D, theta_num_bins, rho_num_bins);
    end
    maximum = max(hough_img(:));
    hough_img = hough_img ./maximum  .* 255;
    % Calculate rho and theta for the edge pixels
    
    % Map to an index in the hough_img array
    % and accumulate votes.
    
    % ---------------------------
    % END YOUR CODE HERE    
    % ---------------------------
end

function voter_indicator = theta_rho_voter(x,y,D,theta_num_bins, rho_num_bins)
    voter_indicator = zeros(rho_num_bins, theta_num_bins);
    for i=1:theta_num_bins
        theta = pi / theta_num_bins * (i - 0.5);
        rho = y*cos(theta) + x*sin(theta);
        j = ceil((rho + D) / (2*D) * rho_num_bins + 0.5);
        voter_indicator(j, i) = 1;
    end
end