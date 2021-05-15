function ujk = ujk_func(centre_pixel,bias_window,mask,class_means,filter_size,sigma,k,q)
%UJK_FUNC 

if mask == 0
    ujk = 0;
    return
end

dkj = dkj_func(centre_pixel,bias_window,class_means,filter_size,sigma,k);
num = (1/dkj)^(1/(q-1));
den = 0;

k_max = length(class_means);
   
for m = 1:k_max
    dkj_cur = dkj_func(centre_pixel,bias_window,class_means,filter_size,sigma,m);
    den = den + (1/dkj_cur)^(1/(q-1));
end

ujk = num/den;    

end

