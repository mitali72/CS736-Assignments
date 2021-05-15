function [vec, val, mean_vec] = Variation_modes(mean_shape,aligned_pointsets)
%VARIATION_MODES 

vec_length = size(mean_shape, 2);
cov = zeros(2*vec_length);

for i = 1:size(aligned_pointsets, 3)  
    
    aligned = aligned_pointsets(:,:,i);
    point_vec = zeros(2*vec_length, 1);
    mean_vec = zeros(2*vec_length, 1);
    
    for j = 1:vec_length
        
        point_vec(2*j-1) = aligned(1,j);
        point_vec(2*j) = aligned(2,j);
        
        mean_vec(2*j-1) = mean_shape(1,j);
        mean_vec(2*j) = mean_shape(2,j);
        
    end
           
    cov = cov + (point_vec - mean_vec)*((point_vec - mean_vec)');

end

cov = cov/size(aligned_pointsets, 3);

[vec, val] = eig(cov, 'vector');
[val, ind] = sort(val);
vec = vec(:, ind);

end

