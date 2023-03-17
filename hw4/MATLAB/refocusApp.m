function refocusApp(rgb_stack, depth_map)
    % pick the first frame to display
    img = rgb_stack(:, :, 1:3);
    [height, width] = size(img, 1:2);
    imshow(img);
    
    while true
        % get user input
        [x, y] = ginput(1);        
        x = round(x);
        y = round(y);
        
        %check border
        if x <= 0 || x > width || y<=0 || y > height
            break
        end
        
        % find the frame index using index_map
        index = depth_map(y, x);
        img = rgb_stack(:, :, (index-1)*3+1 : index*3);
        imshow(img);
    end
    close;
end