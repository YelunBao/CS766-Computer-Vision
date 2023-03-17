function [rgb_stack, gray_stack] = loadFocalStack(focal_stack_dir)
    rgb_stack = [];
    gray_stack = [];
    
    filePattern = fullfile(focal_stack_dir, '*.jpg');
    focal_stack_files = dir(filePattern);

    for i=1:length(focal_stack_files)
        img = imread(fullfile(focal_stack_dir, focal_stack_files(i).name));
        rgb_stack = cat(3, rgb_stack, img);
        gray_stack = cat(3, gray_stack, rgb2gray(img));
    end
end