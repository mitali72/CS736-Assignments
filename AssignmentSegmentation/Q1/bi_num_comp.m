function num_val = bi_num_comp(orig_image,mask,class_means,ujk_vector,weights,q)
%BI_NUM_COMP 

if mask == 0
    num_val = 1;
    return
end

ujk_sum = zeros(256);

sz = size(ujk_vector);
k_max = sz(3);

for k=1:k_max
    ujk_sum = ujk_sum + (ujk_vector(:,:,k).^q)*class_means(k);
end

num_comp = ujk_sum.*orig_image.*cell2mat(weights);
num_val = sum(num_comp, 'all');

end

