function num = ck_num_comp(orig_pixel,mask,bias_field,ujk,weights,q)
%CK_NUM 

if mask == 0
    num = 0;
    return
end

wij_bi = cell2mat(weights).*bias_field;
wij_bi_sum = sum(wij_bi, 'all');
num = (ujk^q)*orig_pixel*wij_bi_sum;

end

