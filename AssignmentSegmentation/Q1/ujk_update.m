function new_ujk_vector = ujk_update(image,mask,bias_field,class_means,filter_size,sigma,ujk_vector,q)
%UJK_UPDATE 

sz = size(ujk_vector);
k_max = sz(3);

new_ujk_vector = zeros([256 256 k_max]);

bias_windows = window_func(bias_field, filter_size);

for k = 1:k_max
    
    ujk_component = arrayfun(@(x,y,z) ujk_func(x,y,z,class_means,filter_size,sigma,k,q), double(image), bias_windows, double(mask));
    new_ujk_vector(:,:,k) = ujk_component;     
   
end
    

end

