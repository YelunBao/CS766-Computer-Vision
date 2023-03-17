Challenge 1a: I directly choose four corners of the portrait as the key points we use. As for backwardWarpImg function,
after calling applyHomography to compute the src_X and src_Y, for each channel, we use interp2() to interpolate src_X and
src_Y in the corresponding region of result_img. Then, get the mask by checking whether a pixel equal to 0.

Challenge 1b: In runRANSAC function, write a for loop with ransac_n iterations. In each iteration, randomly pick 4 pairs of points
from Xs and Xd. Then, compute Homography based on the picked points. Use this Homography to map Xs to the destination img, which we call dest_Xd. Compute the Euclidean distance between Xd and dest_Xd. If one pair's distance less than ransac_eps,
we say it is inlier and add it to the return array. After ransac_n trials, we find the best trial and use its Homography and inlier array.
We set ransac_n as 100 and ransac_eps as 5. It works pretty well.

Challenge 1c: In blendImagePair function,  use the MATLAB function bwdist() to compute a new weighted mask for blending. 
We normalize mask by norm_mask = bwdist(~mask) ./ max(bwdist(~mask)); Then, every channel will use the norm_mask as its weight.

Challenge 1d: In stitchImg function,  we combine the above functions together. Call runRANSAC to get a good Homography, 
then call backwardWarpImg to wrap img_n, and finally call blendImagePair to stitch the images.

Challenge 1e: I took two photos in the front of Lowell E Noland Zoology Building. One is left and the other is right. I use these two 
image to get a LN_panorama.png.