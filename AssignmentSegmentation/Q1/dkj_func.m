function dist = dkj_func(centre_pixel,bias_window,class_means,filter_size,sigma,k)
%DJK_FUNC To compute generalized distance between voxel j and kth mean

kth_mean = class_means(k);
new_bias = kth_mean*cell2mat(bias_window);

image_window = ones(filter_size)*centre_pixel;
gaussian_weights = Gaussian_mask(filter_size,centre_pixel,sigma);

image_diff = image_window - new_bias;
image_diff = image_diff.^2;
dist_matrix = image_diff.*gaussian_weights;
dist = sum(dist_matrix, 'all');

end

