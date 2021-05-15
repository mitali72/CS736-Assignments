function obj = objective(image,mask,bias_field,class_means,filter_size,sigma,ujk_vector,q)
%OBJECTIVE To compute the objective function

sz = size(ujk_vector);
k_max = sz(3);

obj = 0;

bias_windows = window_func(bias_field, filter_size);

for k = 1:k_max
    
    dkj_val = arrayfun(@(x,y) dkj_func(x,y,class_means,filter_size,sigma,k), image, bias_windows);
    
    ujk_val = ujk_vector(:,:,k).^q;
    ujk_dkj = ujk_val.*dkj_val.*mask;
    val = sum(ujk_dkj, 'all');
    obj = obj + val;
   
end

end

