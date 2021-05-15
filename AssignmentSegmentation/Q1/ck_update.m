function new_ck_vector = ck_update(orig_image,mask,bias_field,filter_size,sigma,ujk_vector,q)
%CK_UPDATE 

sz = size(ujk_vector);
k_max = sz(3);

new_ck_vector = zeros(k_max, 1);
weights = j_weights(orig_image,filter_size,sigma);

for k=1:k_max
    
    ujk = ujk_vector(:,:,k);
    num = arrayfun(@(w,x,y,z) ck_num_comp(w,x,bias_field,y,z,q), double(orig_image), double(mask), ujk, weights);
    den = arrayfun(@(x,y,z) ck_den_comp(x,bias_field,y,z,q), double(mask), ujk, weights);
    
    num_val = sum(num, 'all');
    den_val = sum(den, 'all');
    new_ck_vector(k) = num_val/den_val;

end

end

