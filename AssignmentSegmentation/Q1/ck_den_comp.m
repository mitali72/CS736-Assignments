function den = ck_den_comp(mask,bias_field,ujk,weights,q)
%CK_DEN

if mask == 0
    den = 0;
    return
end

bi2 = bias_field.^2;
wij_bi2 = cell2mat(weights).*bi2;
wij_bi2_sum = sum(wij_bi2, 'all');
den = (ujk^q)*wij_bi2_sum;

end

