function [inliers_id, H] = runRANSAC(Xs, Xd, ransac_n, eps)
%RUNRANSAC
    num_pts = size(Xs, 1);
    pts_id = 1:num_pts;
    inliers_id = [];
    max_record = 0;

    for iter = 1:ransac_n
        % ---------------------------
        % START ADDING YOUR CODE HERE
        % ---------------------------
        % num_inliers = 0;
        % ???
        rand_samples = randi(num_pts,1,4);
        H_3x3 = computeHomography(Xs(rand_samples,:), Xd(rand_samples,:));

        dest_Xd = applyHomography(H_3x3, Xs);
        distance = vecnorm(dest_Xd - Xd, 2, 2);
        % max(distance)
        I = find(distance < eps);
        num_inliers = size(I,1);
        %num_inliers
        %max_record
        if num_inliers > max_record
            H = H_3x3;
            inliers_id = I;
            max_record = num_inliers;
        end
        % ---------------------------
        % END ADDING YOUR CODE HERE
        % ---------------------------
    end    
end
