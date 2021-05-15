function den_val = bi_den_comp(mask,class_means,ujk_vector,weights,q)
%BI_DEN_COMP 

if mask == 0
    den_val = 1;
    return
end

ujk_sum = zeros(256);

sz = size(ujk_vector);
k_max = sz(3);

for k=1:k_max
    ujk_sum = ujk_sum + (ujk_vector(:,:,k).^q)*(class_means(k)^2);
end

den_comp = ujk_sum.*cell2mat(weights);
den_val = sum(den_comp, 'all');

end

