function new_bi = bi_update(orig_image,mask,class_means,filter_size,sigma,ujk_vector,q)
%BI_COMP 

weights = i_weights(orig_image,filter_size,sigma);

nums = arrayfun(@(x,y) bi_num_comp(double(orig_image),x,class_means,ujk_vector,y,q), double(mask), weights);
dens = arrayfun(@(x,y) bi_den_comp(x,class_means,ujk_vector,y,q), double(mask), weights);

new_bi = nums./dens;

end

